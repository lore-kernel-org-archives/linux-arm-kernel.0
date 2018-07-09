From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 9 Jul 2018 08:18:40 +0000
Subject: [PATCH v2 1/4] clk: imx7d: add IMX7D_MU_ROOT_CLK
In-Reply-To: <20180615095107.24610-2-o.rempel@pengutronix.de>
References: <20180615095107.24610-1-o.rempel@pengutronix.de>
 <20180615095107.24610-2-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB4211C3AFCCF832121B88492B80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Friday, June 15, 2018 5:51 PM
> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> clk at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH v2 1/4] clk: imx7d: add IMX7D_MU_ROOT_CLK
> 
> This clock is needed for iMX mailbox driver
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

I think this can go separately through CLK tree.

Regards
Dong Aisheng

> ---
>  drivers/clk/imx/clk-imx7d.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c index
> 975a20d3cc94..c7159bfac77a 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -795,6 +795,7 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_DRAM_ALT_ROOT_CLK] =
> imx_clk_gate4("dram_alt_root_clk", "dram_alt_post_div", base + 0x4130, 0);
>  	clks[IMX7D_OCOTP_CLK] = imx_clk_gate4("ocotp_clk",
> "ipg_root_clk", base + 0x4230, 0);
>  	clks[IMX7D_SNVS_CLK] = imx_clk_gate4("snvs_clk", "ipg_root_clk",
> base + 0x4250, 0);
> +	clks[IMX7D_MU_ROOT_CLK] = imx_clk_gate4("mu_root_clk",
> "ipg_root_clk",
> +base + 0x4270, 0);
>  	clks[IMX7D_CAAM_CLK] = imx_clk_gate4("caam_clk", "ipg_root_clk",
> base + 0x4240, 0);
>  	clks[IMX7D_USB_HSIC_ROOT_CLK] =
> imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4690, 0);
>  	clks[IMX7D_SDMA_CORE_CLK] = imx_clk_gate4("sdma_root_clk",
> "ahb_root_clk", base + 0x4480, 0);
> --
> 2.17.1
