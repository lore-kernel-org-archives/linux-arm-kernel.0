From: rogerq@ti.com (Roger Quadros)
Date: Fri, 14 Feb 2014 15:12:47 +0200
Subject: [PATCH v7 03/12] mfd: omap-usb-host: Use clock names as per
 function for reference clocks
In-Reply-To: <20140214100915.GD7380@lee--X1>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
 <1392200333-28397-4-git-send-email-rogerq@ti.com>
 <20140214100915.GD7380@lee--X1>
Message-ID: <52FE164F.80503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2014 12:09 PM, Lee Jones wrote:
>> Use a meaningful name for the reference clocks so that it indicates the function.
>>
>> CC: Lee Jones <lee.jones@linaro.org>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mfd/omap-usb-host.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 60a3bed..ce620a8 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -714,21 +714,21 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>  		goto err_mem;
>>  	}
>>  
>> -	omap->xclk60mhsp1_ck = devm_clk_get(dev, "xclk60mhsp1_ck");
>> +	omap->xclk60mhsp1_ck = devm_clk_get(dev, "refclk_60m_ext_p1");
> 
> You can't do that. These changes will have to be in the same patch as
> the core change i.e. where they are initialised.

I'm not touching them anywhere in this series. When core changes are you
referring to?

> 
>>  	if (IS_ERR(omap->xclk60mhsp1_ck)) {
>>  		ret = PTR_ERR(omap->xclk60mhsp1_ck);
>>  		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
>>  		goto err_mem;
>>  	}
>>  
>> -	omap->xclk60mhsp2_ck = devm_clk_get(dev, "xclk60mhsp2_ck");
>> +	omap->xclk60mhsp2_ck = devm_clk_get(dev, "refclk_60m_ext_p2");
>>  	if (IS_ERR(omap->xclk60mhsp2_ck)) {
>>  		ret = PTR_ERR(omap->xclk60mhsp2_ck);
>>  		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
>>  		goto err_mem;
>>  	}
>>  
>> -	omap->init_60m_fclk = devm_clk_get(dev, "init_60m_fclk");
>> +	omap->init_60m_fclk = devm_clk_get(dev, "refclk_60m_int");
>>  	if (IS_ERR(omap->init_60m_fclk)) {
>>  		ret = PTR_ERR(omap->init_60m_fclk);
>>  		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
> 

--
cheers,
-roger
