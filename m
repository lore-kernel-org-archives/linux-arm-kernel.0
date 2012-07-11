From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2012 08:50:27 +0200
Subject: [PATCH 2/3] ARM: i.MX5x clocks: Fix parent for PWM clocks
In-Reply-To: <1341946469-25984-2-git-send-email-shc_work@mail.ru>
References: <20120709082700.GM24458@pengutronix.de>
 <1341946469-25984-2-git-send-email-shc_work@mail.ru>
Message-ID: <20120711065027.GG30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 10:54:28PM +0400, Alexander Shiyan wrote:
> This patch also changes the names of the clocks to reflect the changes.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index d9cb79f..50e6043 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -57,7 +57,7 @@ enum imx5_clks {
>  	usboh3_podf, usb_phy_pred, usb_phy_podf, cpu_podf, di_pred, tve_di,
>  	tve_s, uart1_ipg_gate, uart1_per_gate, uart2_ipg_gate,
>  	uart2_per_gate, uart3_ipg_gate, uart3_per_gate, i2c1_gate, i2c2_gate,
> -	gpt_ipg_gate, pwm1_ipg_gate, pwm1_hf_gate, pwm2_ipg_gate, pwm2_hf_gate,
> +	gpt_ipg_gate, pwm1_ipg_gate, pwm1_per_gate, pwm2_ipg_gate, pwm2_per_gate,
>  	gpt_gate, fec_gate, usboh3_per_gate, esdhc1_ipg_gate, esdhc2_ipg_gate,
>  	esdhc3_ipg_gate, esdhc4_ipg_gate, ssi1_ipg_gate, ssi2_ipg_gate,
>  	ssi3_ipg_gate, ecspi1_ipg_gate, ecspi1_per_gate, ecspi2_ipg_gate,
> @@ -170,9 +170,9 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk[i2c2_gate] = imx_clk_gate2("i2c2_gate", "per_root", MXC_CCM_CCGR1, 20);
>  	clk[gpt_ipg_gate] = imx_clk_gate2("gpt_ipg_gate", "ipg", MXC_CCM_CCGR2, 20);
>  	clk[pwm1_ipg_gate] = imx_clk_gate2("pwm1_ipg_gate", "ipg", MXC_CCM_CCGR2, 10);
> -	clk[pwm1_hf_gate] = imx_clk_gate2("pwm1_hf_gate", "ipg", MXC_CCM_CCGR2, 12);
> +	clk[pwm1_per_gate] = imx_clk_gate2("pwm1_per_gate", "per_root", MXC_CCM_CCGR2, 12);
>  	clk[pwm2_ipg_gate] = imx_clk_gate2("pwm2_ipg_gate", "ipg", MXC_CCM_CCGR2, 14);
> -	clk[pwm2_hf_gate] = imx_clk_gate2("pwm2_hf_gate", "ipg", MXC_CCM_CCGR2, 16);
> +	clk[pwm2_per_gate] = imx_clk_gate2("pwm2_per_gate", "per_root", MXC_CCM_CCGR2, 16);

We should stick more closely to the clock names in the datasheet inside
the clock tree. Inside the clock tree the clock really is named 'hf'.
This makes matching the code with the datasheet easier.
So please resend this one with only the functional change included, no
renaming.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
