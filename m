From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 2 Sep 2015 12:07:01 +0530
Subject: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from
 sdhci_add_host() fn
In-Reply-To: <1441139838.12163.5.camel@perches.com>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
 <1441139838.12163.5.camel@perches.com>
Message-ID: <55E6990D.3000407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 02 September 2015 02:07 AM, Joe Perches wrote:
> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>> Return value would give clear information about the actual root-cause
>> of the failure.
>
> I'm not sure why that is as nearly every error path in
> sdhci_add_host emits a message.
>

Not for everything.
No error message for -EPROBE_DEFER.

>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> []
>> @@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>
>>   	ret = sdhci_add_host(host);
>>   	if (ret) {
>> -		dev_err(&pdev->dev, "failed to add host\n");
>> +		dev_err(&pdev->dev, "failed to add host ret - %d\n", ret);
>>   		goto err_add_host;
>>   	}
>>
>
> If this is really desirable, there are many other callers of
> sdhci_add_host with error messages just like this one.
>

Yes, true.
Ho about, adding pr_err into sdhci_add_host for -EPROBE_DEFER.

Thanks,
Vaibhav
