From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 20 Aug 2015 17:06:49 +0530
Subject: [PATCH 2/5] ARM: EXYNOS: Remove SROM related register settings
 from mach-exynos
In-Reply-To: <5565B0D1.80004@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
 <1430296712-10287-3-git-send-email-pankaj.dubey@samsung.com>
 <5565B0D1.80004@samsung.com>
Message-ID: <55D5BBD1.1030905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Wednesday 27 May 2015 05:26 PM, Krzysztof Kozlowski wrote:
> W dniu 29.04.2015 o 17:38, Pankaj Dubey pisze:
>> As now we have dedicated driver for SROM controller, it will take care
>> of saving register banks during S2R so we can safely remove these
>> settings from mach-exynos.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/Kconfig                   |  2 +
>>   arch/arm/mach-exynos/exynos.c                  | 10 -----
>>   arch/arm/mach-exynos/include/mach/map.h        |  3 --
>>   arch/arm/mach-exynos/suspend.c                 | 20 +---------
>>   arch/arm/plat-samsung/include/plat/map-s5p.h   |  1 -
>>   arch/arm/plat-samsung/include/plat/regs-srom.h | 54 --------------------------
>>   6 files changed, 4 insertions(+), 86 deletions(-)
>>   delete mode 100644 arch/arm/plat-samsung/include/plat/regs-srom.h
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 603820e..e842b23 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -25,6 +25,8 @@ menuconfig ARCH_EXYNOS
>>   	select S5P_DEV_MFC
>>   	select SRAM
>>   	select MFD_SYSCON
>> +	select SOC_SAMSUNG
>> +	select EXYNOS_SROM
>
> What about the difference of execution time? The suspend/resume of
> device may not be called in the same time as previous syscore ops. Does
> this have any impact?
>


I had tested it for S2R at that time on SMDK5250 board and it was fine. 
I do not noticed any issue in S2R, so I feel timing should not have any 
impact.

Thanks,
Pankaj Dubey

> Best regards,
> Krzysztof
>
>
