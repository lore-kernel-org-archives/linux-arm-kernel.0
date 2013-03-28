From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Mar 2013 13:09:31 -0700
Subject: [PATCHv3 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <20130328152255.GD30477@e106331-lin.cambridge.arm.com>
References: <1363198676-30417-1-git-send-email-sboyd@codeaurora.org>
 <1363198676-30417-4-git-send-email-sboyd@codeaurora.org>
 <20130328152255.GD30477@e106331-lin.cambridge.arm.com>
Message-ID: <5154A37B.1070407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/13 08:22, Mark Rutland wrote:
> This works on my A9x4 coretile, bringing CPUs up and down via
> /sys/devices/system/cpu/*/online, so:
>
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks. I still need to resolve patch #1 though.

>
> Otherwise, is there any reason we couldn't now use the twd driver on a UP
> system? Or would the overhead of handling frequency change make this pointless?

I don't see why not but I don't have any interest in pursuing it.

>
> On Wed, Mar 13, 2013 at 06:17:49PM +0000, Stephen Boyd wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 5b71469..5ad2ccf 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1527,6 +1527,7 @@ config SMP
>>  	depends on HAVE_SMP
>>  	depends on MMU
>>  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
>> +	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
> Could you not depend on your "Push selects for TWD/SCU into machine entries"
> for this?

Right now the patches don't depend on the push down patch. Are you
saying it would be better to depend on that patch?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
