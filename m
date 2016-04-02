From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Apr 2016 18:27:31 -0700
Subject: [PATCH v4 3/5] clk: mvebu: new driver for Armada AP806 system
 controller
In-Reply-To: <1459070777-18049-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459070777-18049-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160402012731.GE18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27, Thomas Petazzoni wrote:
> diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
> new file mode 100644
> index 0000000..c33c209
> --- /dev/null
> +++ b/drivers/clk/mvebu/ap806-system-controller.c
> @@ -0,0 +1,106 @@
> +
> +#define pr_fmt(fmt) "ap806-system-controller: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>

Is this used?

> +#include <linux/clk-provider.h>
> +#include <linux/io.h>

Is this used?

> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +
> +#define AP806_SAR_REG			0x400
> +#define AP806_SAR_CLKFREQ_MODE_MASK	0x1f
> +
> +#define AP806_CLK_NUM 			4
> +
> +static struct clk *ap806_clks[AP806_CLK_NUM];
> +
> +static struct clk_onecell_data ap806_clk_data = {
> +	.clks = ap806_clks,
> +	.clk_num = AP806_CLK_NUM,
> +};
> +
> +static void __init ap806_syscon_clk_init(struct device_node *np)

Can this be a platform driver instead?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
