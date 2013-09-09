From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 09 Sep 2013 16:10:37 -0700
Subject: [PATCH 2/2] ARM: msm: Create a common board-dt and config
 ARCH_MSM_DT
In-Reply-To: <1378767719-27688-2-git-send-email-rvaswani@codeaurora.org>
References: <1378767719-27688-1-git-send-email-rvaswani@codeaurora.org>
 <1378767719-27688-2-git-send-email-rvaswani@codeaurora.org>
Message-ID: <522E556D.1070108@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/13 16:01, Rohit Vaswani wrote:
> diff --git a/arch/arm/mach-msm/board-dt.c b/arch/arm/mach-msm/board-dt.c
> new file mode 100644
> index 0000000..c140c53
> --- /dev/null
> +++ b/arch/arm/mach-msm/board-dt.c
> @@ -0,0 +1,32 @@
> +/* Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.

Bump to 2013?

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include "common.h"
> +
> +static const char *msm_dt_match[] __initdata = {

static const char * const msm_dt_match[] __initconst is better.

> +	"qcom,msm8660-fluid",
> +	"qcom,msm8660-surf",
> +	"qcom,msm8960-cdp",
> +	NULL
> +};
> +
> +DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
> +	.smp = smp_ops(msm_smp_ops),
> +	.dt_compat = msm_dt_match,
> +MACHINE_END

Otherwise feel free to add my reviewed-by.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
