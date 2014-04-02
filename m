From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Apr 2014 13:27:47 +0200
Subject: [PATCH 03/10] ARM: EXYNOS: Move SYSREG definition into sys-reg
 specific file
In-Reply-To: <1396425058-4012-4-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <533BF433.6000209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/04/14 09:50, Pankaj Dubey wrote:
> From: Young-Gun Jang <yg1004.jang@samsung.com>
> 
> While making PMU (Power Mengement Unit) implementation device tree based,
> there are few offsets related with SYSREG present in regs-pmu.h, so let's
> make a new header file "regs-sys.h" to keep all such SYSREG related
> register definition and remove them from "regs-pmu.h"
> 
> Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c   |    1 +
>  arch/arm/mach-exynos/pm.c       |    1 +
>  arch/arm/mach-exynos/regs-pmu.h |    3 ---
>  arch/arm/mach-exynos/regs-sys.h |   22 ++++++++++++++++++++++
>  4 files changed, 24 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/regs-sys.h
[...]
> diff --git a/arch/arm/mach-exynos/regs-sys.h b/arch/arm/mach-exynos/regs-sys.h
> new file mode 100644
> index 0000000..84332b0
> --- /dev/null
> +++ b/arch/arm/mach-exynos/regs-sys.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * EXYNOS - system register definition
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_SYS_H
> +#define __ASM_ARCH_REGS_SYS_H __FILE__
> +
> +#include <mach/map.h>
> +
> +#define S5P_SYSREG(x)                          (S3C_VA_SYS + (x))
> +
> +/* For EXYNOS5 */
> +#define EXYNOS5_SYS_I2C_CFG                    S5P_SYSREG(0x0234)

Can this be defined as a regular register offset in a header file
placed at include/linux/mfd/syscon/ ? I.e. can the mfd syscon driver be
used instead of these hacks ?

-- 
Thanks,
Sylwester
