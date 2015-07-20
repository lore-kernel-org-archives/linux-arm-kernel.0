From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jul 2015 14:20:54 -0700
Subject: [PATCH v8 6/9] nvmem: qfprom: Add Qualcomm QFPROM support.
In-Reply-To: <1437403445-4348-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1437403352-4091-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1437403445-4348-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55AD6636.4050302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2015 07:44 AM, Srinivas Kandagatla wrote:
> This patch adds QFPROM support driver which is used by other drivers
> like thermal sensor and cpufreq.
>
> On MSM parts there are some efuses (called qfprom) these fuses store
> things like calibration data, speed bins.. etc. Drivers like cpufreq,
> thermal sensors would read out this data for configuring the driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

One comment below, otherwise

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> new file mode 100644
> index 0000000..ba5e2b4
> --- /dev/null
> +++ b/drivers/nvmem/qfprom.c
> @@ -0,0 +1,86 @@
> +/*
> + * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>

This include is used?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
