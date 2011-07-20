From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Jul 2011 21:22:18 +0900
Subject: [PATCH v3 0/6] Update Samsung-SoC ADC to support recent CPUs
In-Reply-To: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <069401cc46d7$d33dfdf0$79b9f9d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Patch 1/6: Add regulator support in ADC driver.
> 	If CONFIG_REGULATOR is enabled, "vdd" regulator for the ADC driver
> 	(e.g., "s5p-adc") should exist for the adc driver.
> 
> Patch 2/6: Channel selection method for S5PC110 and Exynos4
> 	Recent Samsung SoCs have different register addresses for
> 	channel selection. Use "s5p-adc" to support such chips.
> 
> Patch 3/6: Bugfix for suspend/resume of ADC driver.
> 
> Patch 4/6: Support ADC at Exynos4
> 	Define register addresses and device name for Exynos4
> 
> Patch 5/6: Support ADC at S5PC110/S5PV210
> 	Correct ADC device name for S5PC110/S5PV210
> 
> Patch 6/6: Header file correction (plat/devs.h)
> 	The long-overdue bugfix for compiler errors. ADC for Exynos4 fails
to
> 	be compiled without this patch.
> 
> 
> MyungJoo Ham (6):
>   Samsung SoC ADC: use regulator (VDD for ADC).
>   Samsung SoC ADC: Channel selection for S5PV210, S5PC110, and Exynos4
>   Samsung SoC ADC: Revise PM for 12-bit ADC operations
>   ARM: EXYNOS4: Support ADC
>   ARM: S5PC110/S5PV210: Support ADC
>   Samsung SoC: header file revised to prevent declaring duplicated.
> 
>  arch/arm/mach-exynos4/Kconfig                 |    1 +
>  arch/arm/mach-exynos4/cpu.c                   |    4 +
>  arch/arm/mach-exynos4/include/mach/irqs.h     |    3 +
>  arch/arm/mach-exynos4/include/mach/map.h      |    5 ++
>  arch/arm/mach-s5pv210/cpu.c                   |    2 +-
>  arch/arm/plat-samsung/adc.c                   |   84
> +++++++++++++++++++------
>  arch/arm/plat-samsung/include/plat/devs.h     |    5 ++
>  arch/arm/plat-samsung/include/plat/regs-adc.h |    1 +
>  8 files changed, 84 insertions(+), 21 deletions(-)
> 
> --
> 1.7.4.1

OK, applied but some comments.

- If you want to add just 'note', please add it under '---' not '--'.
- I don't think we need many developers in Cc like your Cc list.
- We should fix S3C SoCs' breaks during 3.1-rc.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
