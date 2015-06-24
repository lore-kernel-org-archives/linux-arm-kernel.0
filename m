From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Jun 2015 15:07:05 -0700
Subject: [PATCH v6 6/9] nvmem: qfprom: Add Qualcomm QFPROM support.
In-Reply-To: <1435014556-26392-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014556-26392-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <558B2A09.3020407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2015 04:09 PM, Srinivas Kandagatla wrote:
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> new file mode 100644
> index 0000000..7f7a82f
> --- /dev/null
> +++ b/drivers/nvmem/qfprom.c
> @@ -0,0 +1,89 @@
>
> +
> +#include <linux/platform_device.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/device.h>
> +#include <linux/io.h>

Is this include used?

> +#include <linux/module.h>
> +#include <linux/delay.h>

Is this include used?

> +#include <linux/of.h>
> +
> +static struct regmap_config qfprom_regmap_config = {

Can this be const?

> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.reg_stride = 1,
> +};
> +
> +static struct nvmem_config econfig = {

And this one too?

> +	.name = "qfprom",
> +	.owner = THIS_MODULE,
> +};
> +


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
