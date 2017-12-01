From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 1 Dec 2017 10:18:18 +0200
Subject: [PATCH v3 1/4] omapdrm: panel: fix compatible vendor string for
 td028ttec1
In-Reply-To: <20171201015730.nvw6sblxn566dhhb@rob-hp-laptop>
References: <cover.1511884135.git.hns@goldelico.com>
 <6ae8f4b7d794c536650cc99025e5b026089cea30.1511884135.git.hns@goldelico.com>
 <20171201015730.nvw6sblxn566dhhb@rob-hp-laptop>
Message-ID: <da3ce573-1593-3377-1243-ff500e9522b3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/17 03:57, Rob Herring wrote:

>> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> index 0a38a0e8c925..a0dfa14f4fab 100644
>> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> @@ -452,6 +452,8 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
>>  }
>>  
>>  static const struct of_device_id td028ttec1_of_match[] = {
>> +	{ .compatible = "omapdss,tpo,td028ttec1", },
> 
> Why the omapdss part?

This driver is omapdrm specific. But I don't want the dts file to have
omapdrm specific compatible strings, so that the dts files do not have
to be changed when in the future we move to common DRM panel drivers

So:

- In the .dts, we have compatible = "tpo,td028ttec1"
- At early boot time, we append "omapdss," to compatible strings for
panels connected to the DSS node.
- The omapdrm specific drivers match to "omapdss,tpo,td028ttec1"

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
