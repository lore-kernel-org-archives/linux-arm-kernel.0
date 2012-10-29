From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 29 Oct 2012 22:20:43 +0100
Subject: [PATCH 2/2] ARM: mach-imx: CAN clock fix for i.MX53
In-Reply-To: <1351164400-27940-2-git-send-email-stigge@antcom.de>
References: <1351164400-27940-1-git-send-email-stigge@antcom.de>
 <1351164400-27940-2-git-send-email-stigge@antcom.de>
Message-ID: <20121029212043.GA1641@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roland,

Do you have updates on this one? I think this patch is wrong, specifying
the clock rate in the devicetree is only for PowerPC, so I think this
needs further investigation.

Sascha

On Thu, Oct 25, 2012 at 01:26:40PM +0200, Roland Stigge wrote:
> This patch fixes CAN clocking on i.MX53.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.orig/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ linux-2.6/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -426,10 +426,10 @@ int __init mx53_clocks_init(unsigned lon
>  	clk[usb_phy2_gate] = imx_clk_gate2("usb_phy2_gate", "usb_phy_sel", MXC_CCM_CCGR4, 12);
>  	clk[can_sel] = imx_clk_mux("can_sel", MXC_CCM_CSCMR2, 6, 2,
>  				mx53_can_sel, ARRAY_SIZE(mx53_can_sel));
> -	clk[can1_serial_gate] = imx_clk_gate2("can1_serial_gate", "can_sel", MXC_CCM_CCGR6, 22);
> -	clk[can1_ipg_gate] = imx_clk_gate2("can1_ipg_gate", "ipg", MXC_CCM_CCGR6, 20);
> -	clk[can2_serial_gate] = imx_clk_gate2("can2_serial_gate", "can_sel", MXC_CCM_CCGR4, 8);
> -	clk[can2_ipg_gate] = imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 6);
> +	clk[can1_serial_gate] = imx_clk_gate2("can1_serial_gate", "can_sel", MXC_CCM_CCGR4, 6);
> +	clk[can1_ipg_gate] = imx_clk_gate2("can1_ipg_gate", "ipg", MXC_CCM_CCGR4, 8);
> +	clk[can2_serial_gate] = imx_clk_gate2("can2_serial_gate", "can_sel", MXC_CCM_CCGR4, 6);
> +	clk[can2_ipg_gate] = imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 8);
>  	clk[i2c3_gate] = imx_clk_gate2("i2c3_gate", "per_root", MXC_CCM_CCGR1, 22);
>  
>  	for (i = 0; i < ARRAY_SIZE(clk); i++)
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
