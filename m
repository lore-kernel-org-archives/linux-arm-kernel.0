From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 6 Mar 2015 11:30:03 -0600
Subject: [PATCH 2/4] ARM: OMAP2+: AM43xx hwmod: Add RTC hwmod for AM43xx
In-Reply-To: <alpine.DEB.2.02.1503060425590.5613@utopia.booyaka.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
 <1425561211-31003-3-git-send-email-d-gerlach@ti.com>
 <alpine.DEB.2.02.1503060425590.5613@utopia.booyaka.com>
Message-ID: <54F9E41B.5010805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,
On 03/05/2015 10:26 PM, Paul Walmsley wrote:
> On Thu, 5 Mar 2015, Dave Gerlach wrote:
> 
>> RTC hwmod is needed for proper operation of PM features like
>> rtcwake and rtc-only mode so reuse the am33xx rtc hwmod.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> index 8eb8592..9070535 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> @@ -889,6 +889,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>>  	&am43xx_l4_ls__dss,
>>  	&am43xx_l4_ls__dss_dispc,
>>  	&am43xx_l4_ls__dss_rfbi,
>> +	&am33xx_l4_wkup__rtc,
>>  	NULL,
>>  };
> 
> Thanks, queued for v4.1.

Thanks, but please note as I just commented in Patch 1 of this series, without
the ti,no-init flag in place that is introduced there this patch will cause the
am43x-epos-evm to fail to boot.

Regards,
Dave

> 
> 
> - Paul
> 
