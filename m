From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 12 Dec 2014 10:33:23 +0100
Subject: [PATCH v2 1/6] ASoC: dwc: Remove unnecessary debug messages and
 tests
In-Reply-To: <1418376671.18092.40.camel@perches.com>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>	
 <97f65b6037b9ac676f6ca7717a230a68cbe81fd1.1418372910.git.Andrew.Jackson@arm.com>
 <1418376671.18092.40.camel@perches.com>
Message-ID: <548AB663.2020207@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2014 10:31 AM, Joe Perches wrote:
[...]
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	if (!res) {
>> -		dev_err(&pdev->dev, "no i2s resource defined\n");
>> -		return -ENODEV;
>> -	}
>> -
>
> Why delete this?
>
>>   	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(dev->i2s_base)) {
>> -		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");
>> +	if (IS_ERR(dev->i2s_base))
>>   		return PTR_ERR(dev->i2s_base);
>> -	}
>
> or this?

devm_ioremap_resource both checks if res is NULL and does also its own error 
reporting. So the code in the driver is redundant.
