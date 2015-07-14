From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jul 2015 14:18:31 -0700
Subject: [PATCH v7 6/9] nvmem: qfprom: Add Qualcomm QFPROM support.
In-Reply-To: <1436521529-10931-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521529-10931-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150714211831.GN30412@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, Srinivas Kandagatla wrote:
> This patch adds QFPROM support driver which is used by other drivers
> like thermal sensor and cpufreq.
> 
> On MSM parts there are some efuses (called qfprom) these fuses store
> things like calibration data, speed bins.. etc. Drivers like cpufreq,
> thermal sensors would read out this data for configuring the driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

I didn't see any reply on v6, but at least delay.h was removed.
Same comments from v6 below.

> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> new file mode 100644
> index 0000000..0e22a03
> --- /dev/null
> +++ b/drivers/nvmem/qfprom.c
> @@ -0,0 +1,87 @@
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
> +#include <linux/io.h>

Is this include used?

> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +static struct regmap_config qfprom_regmap_config = {

Can this be const?

> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.reg_stride = 1,
> +};
> +
> +static struct nvmem_config econfig = {

Can this be const?

> +	.name = "qfprom",
> +	.owner = THIS_MODULE,
> +};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
