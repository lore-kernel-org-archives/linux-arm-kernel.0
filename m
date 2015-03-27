From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Mar 2015 00:39:50 -0700
Subject: [PATCH 4/6] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <1426754530-3137-5-git-send-email-s.hauer@pengutronix.de>
References: <1426754530-3137-1-git-send-email-s.hauer@pengutronix.de>
 <1426754530-3137-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150327073950.GF18059@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19, Sascha Hauer wrote:
> diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
> new file mode 100644
> index 0000000..a22f6fa
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8135.c
> @@ -0,0 +1,640 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: James Liao <jamesjj.liao@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +#include <dt-bindings/clock/mt8135-clk.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +static DEFINE_SPINLOCK(lock);

Nitpick: 'lock' is very generic. Lockdep will use the variable
name in its output, so it's wise to make locks have better names
if possible. How about mt8135_lock?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
