From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 14:32:43 -0700
Subject: [PATCH V4 09/11] clk: imx: add common imx_clk_hw_fixed functions
In-Reply-To: <1539504194-28289-10-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-10-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972556312.5275.17225594568267875356@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-14 01:08:09)
> This may be used by both mmio and scu clks. So let's put it
> into a common file.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/imx/clk-common.h  | 16 ++++++++++++++++
>  drivers/clk/imx/scu/clk-scu.h |  2 ++
>  2 files changed, 18 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-common.h
> 
> diff --git a/drivers/clk/imx/clk-common.h b/drivers/clk/imx/clk-common.h
> new file mode 100644
> index 0000000..e3634a5
> --- /dev/null
> +++ b/drivers/clk/imx/clk-common.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2018 NXP
> + */
> +
> +#ifndef __IMX_CLK_COMMON_H
> +#define __IMX_CLK_COMMON_H
> +
> +#include <linux/clk-provider.h>
> +
> +static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
> +{
> +       return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
> +}

Why do we need this wrapper file? Just call the registration function
directly with the right arguments instead of wrapping them in another
function please.
