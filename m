From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 12 Nov 2015 13:22:59 +0900
Subject: [PATCH v4 4/9] ARM: EXYNOS: split up exynos3250 SoC specific PMU
 data
In-Reply-To: <1447155784-12667-5-git-send-email-pankaj.dubey@samsung.com>
References: <1447155784-12667-1-git-send-email-pankaj.dubey@samsung.com>
 <1447155784-12667-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56441423.9000208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.11.2015 20:42, Pankaj Dubey wrote:
> This patch splits up mach-exynos/pmu.c file, and moves exynos3250 PMU
> configuration data and functions handing those data into exynos3250
> SoC specific PMU file mach-exynos/exynos3250-pmu.c.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile         |   2 +-
>  arch/arm/mach-exynos/exynos-pmu.h     |  40 ++++++++
>  arch/arm/mach-exynos/exynos.c         |   2 -
>  arch/arm/mach-exynos/exynos3250-pmu.c | 175 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/pmu.c            | 184 +---------------------------------
>  5 files changed, 220 insertions(+), 183 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
>  create mode 100644 arch/arm/mach-exynos/exynos3250-pmu.c
> 
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 2f30676..e869f86 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -9,7 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
>  
>  # Core
>  
> -obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o
> +obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o exynos3250-pmu.o
>  
>  obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
>  obj-$(CONFIG_PM_SLEEP)		+= suspend.o
> diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/arch/arm/mach-exynos/exynos-pmu.h
> new file mode 100644
> index 0000000..6f95c7d
> --- /dev/null
> +++ b/arch/arm/mach-exynos/exynos-pmu.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Header for EXYNOS PMU Driver support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __EXYNOS_PMU_H
> +#define __EXYNOS_PMU_H
> +
> +#include <linux/io.h>
> +
> +#define PMU_TABLE_END	(-1U)
> +
> +

Unnecessary blank line.

Rest looks good, so with this fix:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
