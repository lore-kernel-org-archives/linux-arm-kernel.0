From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Fri, 12 Dec 2014 09:39:56 +0000
Subject: [PATCH v2 1/6] ASoC: dwc: Remove unnecessary debug messages and
 tests
In-Reply-To: <1418376671.18092.40.camel@perches.com>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>	
 <97f65b6037b9ac676f6ca7717a230a68cbe81fd1.1418372910.git.Andrew.Jackson@arm.com>
 <1418376671.18092.40.camel@perches.com>
Message-ID: <548AB7EC.4020502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/14 09:31, Joe Perches wrote:
> On Fri, 2014-12-12 at 09:25 +0000, Andrew Jackson wrote:
>> The devm_XXX allocation functions print a message on failure,
>> so additional messages are not required.
> []
>> diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
> []
>> @@ -345,26 +345,17 @@ static int dw_i2s_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
>> -	if (!dw_i2s_dai) {
>> -		dev_err(&pdev->dev, "mem allocation failed for dai driver\n");
>> +	if (!dw_i2s_dai)
>>  		return -ENOMEM;
>> -	}
> 
> ok.
>  
>>  	dw_i2s_dai->ops = &dw_i2s_dai_ops;
>>  	dw_i2s_dai->suspend = dw_i2s_suspend;
>>  	dw_i2s_dai->resume = dw_i2s_resume;
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	if (!res) {
>> -		dev_err(&pdev->dev, "no i2s resource defined\n");
>> -		return -ENODEV;
>> -	}
>> -
> 
> Why delete this?

Lars-Peter said that it was unnecessary: see <http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308416.html>.
> 
>>  	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(dev->i2s_base)) {
>> -		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");
>> +	if (IS_ERR(dev->i2s_base))
>>  		return PTR_ERR(dev->i2s_base);
>> -	}
> 
> or this?

Ditto

	Andrew
