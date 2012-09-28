From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 28 Sep 2012 16:29:49 +0530
Subject: [PATCH v2] ASoC: Samsung: Update Kconfig for Exynos5250 and
 Exynos4412
In-Reply-To: <003401cd9d5f$179495c0$46bdc140$@samsung.com>
References: <1348741777-29569-1-git-send-email-padma.v@samsung.com>
 <003401cd9d5f$179495c0$46bdc140$@samsung.com>
Message-ID: <50658325.8050704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 03:23 PM, Sangsu Park wrote:
> 
> On Thu, Sep 27, 2012 at 07:30 PM, Padmavathi Venna wrote:
> 
>> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
>> index fe3995c..430783b 100644
>> --- a/sound/soc/samsung/Kconfig
>> +++ b/sound/soc/samsung/Kconfig
>> @@ -1,6 +1,6 @@
>>  config SND_SOC_SAMSUNG
>>  	tristate "ASoC support for Samsung"
>> -	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210
>> || ARCH_S5P64X0 || ARCH_EXYNOS4
>> +	depends on PLAT_SAMSUNG
>>  	select S3C64XX_DMA if ARCH_S3C64XX
>>  	select S3C2410_DMA if ARCH_S3C24XX
>>  	help
> 
> This code is already updated.
> 
>> @@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
>>
>>  config SND_SOC_SAMSUNG_SMDK_WM8994
>>  	tristate "SoC I2S Audio support for WM8994 on SMDK"
>> -	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 ||
>> MACH_SMDK4212)
>> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 ||
>> MACH_SMDK4212 || MACH_SMDK4412 || MACH_EXYNOS5_DT)
>>  	depends on I2C=y && GENERIC_HARDIRQS
>>  	select MFD_WM8994
>>  	select SND_SOC_WM8994
> 
> I'm not sure about this since MACH_EXYNOS5_DT can have others instead of SMDK.
> 

But there is no other way we can differentiate between two EXYNOS5_DT
based boards in the kernel. So, support for all possible codecs and
sound-cards should be enabled in the kernel. The instantiation of the
drivers should depend on the device-tree entries.

> Thanks,
> Sangsu.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Tushar Behera
