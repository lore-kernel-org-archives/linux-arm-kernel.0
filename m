From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Oct 2012 10:09:03 +0200
Subject: [PATCH] ARM: imx: clk-imx27: Fix divider width field
In-Reply-To: <1349749200-8332-1-git-send-email-festevam@gmail.com>
References: <1349749200-8332-1-git-send-email-festevam@gmail.com>
Message-ID: <20121009080903.GD27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 11:20:00PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> As per mx27 reference manual, H264DIV and SSI2DIV are 6-bit wide fields in
> register PCDR0.
>  
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/clk-imx27.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
> index 3b6b640..366e5d5 100644
> --- a/arch/arm/mach-imx/clk-imx27.c
> +++ b/arch/arm/mach-imx/clk-imx27.c
> @@ -109,7 +109,7 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk[per3_div] = imx_clk_divider("per3_div", "mpll_main2", CCM_PCDR1, 16, 6);
>  	clk[per4_div] = imx_clk_divider("per4_div", "mpll_main2", CCM_PCDR1, 24, 6);
>  	clk[vpu_sel] = imx_clk_mux("vpu_sel", CCM_CSCR, 21, 1, vpu_sel_clks, ARRAY_SIZE(vpu_sel_clks));
> -	clk[vpu_div] = imx_clk_divider("vpu_div", "vpu_sel", CCM_PCDR0, 10, 3);
> +	clk[vpu_div] = imx_clk_divider("vpu_div", "vpu_sel", CCM_PCDR0, 10, 6);
>  	clk[usb_div] = imx_clk_divider("usb_div", "spll", CCM_CSCR, 28, 3);
>  	clk[cpu_sel] = imx_clk_mux("cpu_sel", CCM_CSCR, 15, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
>  	clk[clko_sel] = imx_clk_mux("clko_sel", CCM_CCSR, 0, 5, clko_sel_clks, ARRAY_SIZE(clko_sel_clks));
> @@ -121,7 +121,7 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk[ssi1_sel] = imx_clk_mux("ssi1_sel", CCM_CSCR, 22, 1, ssi_sel_clks, ARRAY_SIZE(ssi_sel_clks));
>  	clk[ssi2_sel] = imx_clk_mux("ssi2_sel", CCM_CSCR, 23, 1, ssi_sel_clks, ARRAY_SIZE(ssi_sel_clks));
>  	clk[ssi1_div] = imx_clk_divider("ssi1_div", "ssi1_sel", CCM_PCDR0, 16, 6);
> -	clk[ssi2_div] = imx_clk_divider("ssi2_div", "ssi2_sel", CCM_PCDR0, 26, 3);
> +	clk[ssi2_div] = imx_clk_divider("ssi2_div", "ssi2_sel", CCM_PCDR0, 26, 6);
>  	clk[clko_en] = imx_clk_gate("clko_en", "clko_div", CCM_PCCR0, 0);
>  	clk[ssi2_ipg_gate] = imx_clk_gate("ssi2_ipg_gate", "ipg", CCM_PCCR0, 0);
>  	clk[ssi1_ipg_gate] = imx_clk_gate("ssi1_ipg_gate", "ipg", CCM_PCCR0, 1);
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
