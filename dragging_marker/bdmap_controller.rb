    def index

    end
    #百度地图拖东查询地址
    def bd_lookup_axis
      bdurl="http://api.map.baidu.com/geocoder/v2/?ak=C4mDur7zkT8qxOTuLCyc2MGT&callback=renderReverse&location="+
          params[:bdlat]+","+params[:bdlng]+"&output=json&pois=0"
      res=httpnetget(bdurl)
      return_body = res.force_encoding('UTF-8')
      .gsub("renderReverse&&renderReverse","")
      .gsub("(",'').gsub(")",'')
      bdjson=JSON.parse(return_body)
      @result=bdjson["result"]
      if !@result.blank?
        @result
        @bddistrict=@result["addressComponent"]["district"]
        @bdroad=@result["formatted_address"]
        @bdlng=@result["location"]["lng"]
        @bdlat=@result["location"]["lat"]
      end
      @mapsize=params[:mapsize]
      @first_page=false
      respond_to do |format|
        format.js
      end
    end
    #httpget
    def httpnetget bdurl
      url_sms = URI::escape(bdurl)
      url=URI.parse(url_sms)
      return res=Net::HTTP.get(url)
    end
