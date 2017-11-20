From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 20 Nov 2017 12:13:55 +0530
Subject: [PATCH 4/6] mmc: sdhci-spear: Handle return value of
 platform_get_irq
In-Reply-To: <20171120054340.GB6125@vireshk-i7>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510950502-22565-5-git-send-email-arvind.yadav.cs@gmail.com>
 <20171120054340.GB6125@vireshk-i7>
Message-ID: <6c854ee4-c0c9-be2f-cfdc-8feeb6e5ab20@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi viresh,

Could you please acknowledge a latest version of this patch.

Thanks,


On Monday 20 November 2017 11:13 AM, Viresh Kumar wrote:
> On 18-11-17, 01:58, Arvind Yadav wrote:
>> platform_get_irq() can fail here and we must check its return value.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/mmc/host/sdhci-spear.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
>> index 8c0f884..900838b 100644
>> --- a/drivers/mmc/host/sdhci-spear.c
>> +++ b/drivers/mmc/host/sdhci-spear.c
>> @@ -82,6 +82,10 @@ static int sdhci_probe(struct platform_device *pdev)
>>   	host->hw_name = "sdhci";
>>   	host->ops = &sdhci_pltfm_ops;
>>   	host->irq = platform_get_irq(pdev, 0);
>> +	if (host->irq < 0) {
>> +		ret = host->irq;
>> +		goto err_host;
>> +	}
>>   	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
>>   
>>   	sdhci = sdhci_priv(host);
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
