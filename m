From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 05 Nov 2015 10:58:00 +0530
Subject: [PATCH v3 2/7] ARM: EXYNOS: Move pmu specific headers under
 "linux/soc/samsung"
In-Reply-To: <563811FE.6010108@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-3-git-send-email-pankaj.dubey@samsung.com>
 <563811FE.6010108@samsung.com>
Message-ID: <563AE8E0.1030604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 03 November 2015 07:16 AM, Krzysztof Kozlowski wrote:
> On 26.10.2015 21:55, Pankaj Dubey wrote:
>> Moving Exynos PMU specific header file into "include/linux/soc/samsung"
>> thus updated affected files under "mach-exynos" to use new location of
>> these header files.
>>
>> Signed-off-by: Amit Daniel Kachhap <amitdanielk@gmail.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/exynos.c                                     | 2 +-
>>   arch/arm/mach-exynos/mcpm-exynos.c                                | 2 +-
>>   arch/arm/mach-exynos/platsmp.c                                    | 2 +-
>>   arch/arm/mach-exynos/pm.c                                         | 4 ++--
>>   arch/arm/mach-exynos/pmu.c                                        | 6 +++---
>>   arch/arm/mach-exynos/suspend.c                                    | 4 ++--
>>   {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h  | 2 +-
>>   .../regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h     | 8 ++++----
>>   8 files changed, 15 insertions(+), 15 deletions(-)
>>   rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (90%)
>>   rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)
>> diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
>> similarity index 90%
>> rename from arch/arm/mach-exynos/exynos-pmu.h
>> rename to include/linux/soc/samsung/exynos-pmu.h
>> index a2ab0d5..50dd0aa 100644
>> --- a/arch/arm/mach-exynos/exynos-pmu.h
>> +++ b/include/linux/soc/samsung/exynos-pmu.h
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
>
> No changes in file, don't touch the copyright date.
>
> Instead please update the header-inclusion guard:
> __SOC_EXYNOS_PMU_H
> or maybe even (because you added exynos-pmu.h in next patch):
> __LINUX_SOC_EXYNOS_PMU_H
>

OK.

>
>>    *		http://www.samsung.com
>>    *
>>    * Header for EXYNOS PMU Driver support
>> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
>> similarity index 99%
>> rename from arch/arm/mach-exynos/regs-pmu.h
>> rename to include/linux/soc/samsung/exynos-regs-pmu.h
>> index 5e4f4c2..3a5b7ff 100644
>> --- a/arch/arm/mach-exynos/regs-pmu.h
>> +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
>> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
>>    *		http://www.samsung.com
>>    *
>>    * EXYNOS - Power management unit definition
>> @@ -9,8 +9,8 @@
>>    * published by the Free Software Foundation.
>>   */
>>
>> -#ifndef __ASM_ARCH_REGS_PMU_H
>> -#define __ASM_ARCH_REGS_PMU_H __FILE__
>> +#ifndef __EXYNOS_REGS_PMU_H
>> +#define __EXYNOS_REGS_PMU_H __FILE__
>>
>>   #define S5P_CENTRAL_SEQ_CONFIGURATION		0x0200
>>
>> @@ -690,4 +690,4 @@
>>   					 | EXYNOS5420_KFC_USE_STANDBY_WFI2  \
>>   					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
>>
>> -#endif /* __ASM_ARCH_REGS_PMU_H */
>> +#endif /* __EXYNOS_REGS_PMU_H */
>>
>
> ditto, copyright may stay but please add SOC prefix to define.
>

OK. Thanks for review.

Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof
>
>
