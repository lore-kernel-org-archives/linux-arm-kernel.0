From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 24 Oct 2014 20:46:20 +0900
Subject: [PATCH 1/5] ARM: EXYNOS: Add EXYNOS4415 SoC ID
In-Reply-To: <544A3B67.4010507@gmail.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>
 <1413775935-17743-1-git-send-email-cw00.choi@samsung.com>
 <544A3B67.4010507@gmail.com>
Message-ID: <544A3C0C.6060603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 10/24/2014 08:43 PM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 20.10.2014 05:32, Chanwoo Choi wrote:
>> This patch add Exynos4415's SoC ID. Exynos4415 is based on the 32-bit RISC
>> processor for Smartphone. Exynos4415 uses Cortex A9 quad-cores and has a target
>> speed of 1.6GHz and provides 8.5GB/s memory bandwidth.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Kconfig  | 5 +++++
>>  arch/arm/mach-exynos/common.h | 8 ++++++++
>>  arch/arm/mach-exynos/exynos.c | 2 ++
>>  3 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 46f3c0d..349c867 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -75,6 +75,11 @@ config SOC_EXYNOS4412
>>  	default y
>>  	depends on ARCH_EXYNOS4
>>  
>> +config SOC_EXYNOS4415
>> +	bool "SAMSUNG EXYNOS4415"
>> +	default y
>> +	depends on ARCH_EXYNOS4
>> +
>>  config SOC_EXYNOS5250
>>  	bool "SAMSUNG EXYNOS5250"
>>  	default y
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index d4d09bc..ffc0c22 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -21,6 +21,7 @@
>>  #define EXYNOS4210_CPU_ID	0x43210000
>>  #define EXYNOS4212_CPU_ID	0x43220000
>>  #define EXYNOS4412_CPU_ID	0xE4412200
>> +#define EXYNOS4415_CPU_ID	0xE4415000
>>  #define EXYNOS4_CPU_MASK	0xFFFE0000
>>  
>>  #define EXYNOS5250_SOC_ID	0x43520000
>> @@ -42,6 +43,7 @@ IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
>>  IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
>>  IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
>>  IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
>> +IS_SAMSUNG_CPU(exynos4415, EXYNOS4415_CPU_ID, EXYNOS4_CPU_MASK)
> 
> Is there a need for this legacy helper for this SoC?

No, I'll drop it on next patchset.

> 
>>  IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
>>  IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
>>  IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
>> @@ -72,6 +74,12 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
>>  # define soc_is_exynos4412()	0
>>  #endif
>>  
>> +#if defined(CONFIG_SOC_EXYNOS4415)
>> +# define soc_is_exynos4415()	is_samsung_exynos4415()
>> +#else
>> +# define soc_is_exynos4415()	0
>> +#endif
> 
> Ditto.

I'll drop it on next patchset.

Best Regards,
Chanwoo Choi

> 
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
