From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 May 2012 09:47:01 +0200
Subject: [PATCH 1/5] ARM: imx: add more imx5 ssi clocks
In-Reply-To: <1336718568-26810-2-git-send-email-shawn.guo@linaro.org>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120511074701.GD27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 02:42:44PM +0800, Shawn Guo wrote:
> Add more imx5 ssi clocks and lookup for device tree probe.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |   40 +++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
>  	for (i = 0; i < ARRAY_SIZE(clk); i++)
>  		if (IS_ERR(clk[i]))
>  			pr_err("i.MX5 clk %d: register failed with %ld\n",
> @@ -237,6 +269,8 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
>  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
>  	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
> +	clk_register_clkdev(clk[ssi_ext1_gate], NULL, "ssi_ext.0");
> +	clk_register_clkdev(clk[ssi_ext2_gate], NULL, "ssi_ext.1");

Another thing I just noticed is that you use ssi_ext.0|1 as the device id,
is that what you want? I think the device id should either match a real
device present in the system or be NULL.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
