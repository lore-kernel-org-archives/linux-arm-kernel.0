From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 May 2012 16:57:39 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <20120507170832.GO17002@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
Message-ID: <4FB12B73.50302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>   	pdata = dev_get_platdata(ab8500->dev);
>> -	if (!pdata) {
>> -		dev_err(&pdev->dev, "null pdata\n");
>> +	if (!pdata&&  !np) {
>> +		dev_err(&pdev->dev, "null pdata and no device tree found\n");
>>   		return -EINVAL;
>>   	}
>
> Neither should be mandatory.

Unfortunately, this has to reside, as without it I'd have to re-write 
the driver. Something with is completely out of scope of what I'm trying 
to achieve right now. It's something I'd be happy to do in the future, 
but not in this patch-set.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
