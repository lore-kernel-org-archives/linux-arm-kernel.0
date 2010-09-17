From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 17 Sep 2010 16:58:49 +0900
Subject: [PATCH 1/2] ARM: S5PV310: Add PMU for S5PV310 hotplug
In-Reply-To: <1284700388-9394-2-git-send-email-kgene.kim@samsung.com>
References: <1284700388-9394-1-git-send-email-kgene.kim@samsung.com>
	<1284700388-9394-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <000301cb563e$2e4424d0$8acc6e70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> This patch adds PMU(Power Management Unit) for S5PV310/S5PC210 hotplug.
> 
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>

missed...when submitted...
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>  arch/arm/mach-s5pv310/cpu.c                   |    5 +++++
>  arch/arm/mach-s5pv310/include/mach/map.h      |    2 ++
>  arch/arm/mach-s5pv310/include/mach/regs-pmu.h |   25
> +++++++++++++++++++++++++
>  arch/arm/plat-s5p/include/plat/map-s5p.h      |    1 +
>  4 files changed, 33 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-pmu.h
> 
> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
> index 4add398..3a3f90a 100644
> --- a/arch/arm/mach-s5pv310/cpu.c
> +++ b/arch/arm/mach-s5pv310/cpu.c
> @@ -41,6 +41,11 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
>  		.length		= SZ_128K,
>  		.type		= MT_DEVICE,
>  	}, {
> +		.virtual	= (unsigned long)S5P_VA_PMU,
> +		.pfn		= __phys_to_pfn(S5PV310_PA_PMU),
> +		.length		= SZ_16K,
> +		.type		= MT_DEVICE,
> +	}, {
>  		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
>  		.pfn		= __phys_to_pfn(S5PV310_PA_COMBINER),
>  		.length		= SZ_4K,
> diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-
> s5pv310/include/mach/map.h
> index aff6d23..c953c94 100644
> --- a/arch/arm/mach-s5pv310/include/mach/map.h
> +++ b/arch/arm/mach-s5pv310/include/mach/map.h
> @@ -37,6 +37,8 @@
>  #define S5PV310_PA_SYSCON		(0x10010000)
>  #define S5P_PA_SYSCON			S5PV310_PA_SYSCON
> 
> +#define S5PV310_PA_PMU			(0x10020000)
> +
>  #define S5PV310_PA_CMU			(0x10030000)
> 
>  #define S5PV310_PA_WATCHDOG		(0x10060000)
> diff --git a/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
b/arch/arm/mach-
> s5pv310/include/mach/regs-pmu.h
> new file mode 100644
> index 0000000..bb15a40
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
> @@ -0,0 +1,25 @@
> +/* linux/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * S5PV310 - Power management unit definition
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_PMU_H
> +#define __ASM_ARCH_REGS_PMU_H __FILE__
> +
> +#include <mach/map.h>
> +
> +#define S5PV310_PMU(x)			(S5P_VA_PMU + (x))
> +
> +#define S5PV310_ARM_CORE1_CONF		S5P_PMU(0x2080)
> +#define S5PV310_ARM_CORE1_STAT		S5P_PMU(0x2084)
> +
> +#define S5PV310_CORE_PWR_EN		0x3
> +
> +#endif /* __ASM_ARCH_REGS_PMU_H */
> diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-
> s5p/include/plat/map-s5p.h
> index c4ff88b..bee029e 100644
> --- a/arch/arm/plat-s5p/include/plat/map-s5p.h
> +++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
> @@ -31,6 +31,7 @@
> 
>  #define S5P_VA_L2CC		S3C_ADDR(0x00900000)
>  #define S5P_VA_CMU		S3C_ADDR(0x00920000)
> +#define S5P_VA_PMU		S3C_ADDR(0x00940000)
> 
>  #define S5P_VA_UART(x)		(S3C_VA_UART + ((x) *
> S3C_UART_OFFSET))
>  #define S5P_VA_UART0		S5P_VA_UART(0)
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
