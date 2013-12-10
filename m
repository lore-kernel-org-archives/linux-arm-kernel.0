From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Dec 2013 11:20:41 +0100
Subject: [PATCH] ARM i.MX5: fix obvious typo in ldb_di0_gate clk definition
In-Reply-To: <1386670515-6017-1-git-send-email-LW@KARO-electronics.de>
References: <1386670515-6017-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1386670841.4096.6.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Shawn to CC as likely he would be the one taking this patch.

Am Dienstag, den 10.12.2013, 11:15 +0100 schrieb Lothar Wa?mann:
> ldb_di0_gate is registerd with the clk index of IMX5_CLK_LDB_DI1_GATE,
> thus the DI0 interface will be turned off inadvertently during boot.
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index e349fd5..e063d93 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -514,7 +514,7 @@ static void __init mx53_clocks_init(struct device_node *np)
>  	clk[IMX5_CLK_LDB_DI0_DIV]	= imx_clk_divider_flags("ldb_di0_div", "ldb_di0_div_3_5", MXC_CCM_CSCMR2, 10, 1, 0);
>  	clk[IMX5_CLK_LDB_DI0_SEL]	= imx_clk_mux_flags("ldb_di0_sel", MXC_CCM_CSCMR2, 8, 1,
>  						mx53_ldb_di0_sel, ARRAY_SIZE(mx53_ldb_di0_sel), CLK_SET_RATE_PARENT);
> -	clk[IMX5_CLK_LDB_DI1_GATE]	= imx_clk_gate2("ldb_di0_gate", "ldb_di0_div", MXC_CCM_CCGR6, 28);
> +	clk[IMX5_CLK_LDB_DI0_GATE]	= imx_clk_gate2("ldb_di0_gate", "ldb_di0_div", MXC_CCM_CCGR6, 28);
>  	clk[IMX5_CLK_LDB_DI1_GATE]	= imx_clk_gate2("ldb_di1_gate", "ldb_di1_div", MXC_CCM_CCGR6, 30);
>  	clk[IMX5_CLK_IPU_DI0_SEL]	= imx_clk_mux("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
>  						mx53_ipu_di0_sel, ARRAY_SIZE(mx53_ipu_di0_sel));

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
