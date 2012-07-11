From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2012 08:44:06 +0200
Subject: [PATCH 3/3] ARM: i.MX5x clocks: Fix GPT clocks
In-Reply-To: <1341946469-25984-3-git-send-email-shc_work@mail.ru>
References: <20120709082700.GM24458@pengutronix.de>
 <1341946469-25984-3-git-send-email-shc_work@mail.ru>
Message-ID: <20120711064406.GF30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 10:54:29PM +0400, Alexander Shiyan wrote:
> This patch fix incorrect defined bits for GPT clocks according to
> datasheet.

Fix is a strong word. As I can see it these are only cosmetic changes
without any functional change, right?

Sascha

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 50e6043..628e940 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -58,7 +58,7 @@ enum imx5_clks {
>  	tve_s, uart1_ipg_gate, uart1_per_gate, uart2_ipg_gate,
>  	uart2_per_gate, uart3_ipg_gate, uart3_per_gate, i2c1_gate, i2c2_gate,
>  	gpt_ipg_gate, pwm1_ipg_gate, pwm1_per_gate, pwm2_ipg_gate, pwm2_per_gate,
> -	gpt_gate, fec_gate, usboh3_per_gate, esdhc1_ipg_gate, esdhc2_ipg_gate,
> +	gpt_per_gate, fec_gate, usboh3_per_gate, esdhc1_ipg_gate, esdhc2_ipg_gate,
>  	esdhc3_ipg_gate, esdhc4_ipg_gate, ssi1_ipg_gate, ssi2_ipg_gate,
>  	ssi3_ipg_gate, ecspi1_ipg_gate, ecspi1_per_gate, ecspi2_ipg_gate,
>  	ecspi2_per_gate, cspi_ipg_gate, sdma_gate, emi_slow_gate, ipu_s,
> @@ -168,12 +168,12 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk[uart3_per_gate] = imx_clk_gate2("uart3_per_gate", "uart_root", MXC_CCM_CCGR1, 16);
>  	clk[i2c1_gate] = imx_clk_gate2("i2c1_gate", "per_root", MXC_CCM_CCGR1, 18);
>  	clk[i2c2_gate] = imx_clk_gate2("i2c2_gate", "per_root", MXC_CCM_CCGR1, 20);
> -	clk[gpt_ipg_gate] = imx_clk_gate2("gpt_ipg_gate", "ipg", MXC_CCM_CCGR2, 20);
>  	clk[pwm1_ipg_gate] = imx_clk_gate2("pwm1_ipg_gate", "ipg", MXC_CCM_CCGR2, 10);
>  	clk[pwm1_per_gate] = imx_clk_gate2("pwm1_per_gate", "per_root", MXC_CCM_CCGR2, 12);
>  	clk[pwm2_ipg_gate] = imx_clk_gate2("pwm2_ipg_gate", "ipg", MXC_CCM_CCGR2, 14);
>  	clk[pwm2_per_gate] = imx_clk_gate2("pwm2_per_gate", "per_root", MXC_CCM_CCGR2, 16);
> -	clk[gpt_gate] = imx_clk_gate2("gpt_gate", "per_root", MXC_CCM_CCGR2, 18);
> +	clk[gpt_ipg_gate] = imx_clk_gate2("gpt_ipg_gate", "ipg", MXC_CCM_CCGR2, 18);
> +	clk[gpt_per_gate] = imx_clk_gate2("gpt_per_gate", "per_root", MXC_CCM_CCGR2, 20);
>  	clk[fec_gate] = imx_clk_gate2("fec_gate", "ipg", MXC_CCM_CCGR2, 24);
>  	clk[usboh3_gate] = imx_clk_gate2("usboh3_gate", "ipg", MXC_CCM_CCGR2, 26);
>  	clk[usboh3_per_gate] = imx_clk_gate2("usboh3_per_gate", "usboh3_podf", MXC_CCM_CCGR2, 28);
> @@ -237,7 +237,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  			pr_err("i.MX5 clk %d: register failed with %ld\n",
>  				i, PTR_ERR(clk[i]));
>  	
> -	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
> +	clk_register_clkdev(clk[gpt_per_gate], "per", "imx-gpt.0");
>  	clk_register_clkdev(clk[gpt_ipg_gate], "ipg", "imx-gpt.0");
>  	clk_register_clkdev(clk[uart1_per_gate], "per", "imx21-uart.0");
>  	clk_register_clkdev(clk[uart1_ipg_gate], "ipg", "imx21-uart.0");
> -- 
> 1.7.3.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
