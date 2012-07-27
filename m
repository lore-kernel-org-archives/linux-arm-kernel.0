From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Jul 2012 10:27:08 +0200
Subject: [PATCH] ARM: clk-imx31: Fix the keypad clock name
In-Reply-To: <1343329733-14720-1-git-send-email-fabio.estevam@freescale.com>
References: <1343329733-14720-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120727082708.GZ30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:08:53PM -0300, Fabio Estevam wrote:
> Fix the keypad clock name, in order to fix the following error:
> 
> imx-keypad imx-keypad: failed to get keypad clock
> imx-keypad: probe of imx-keypad failed with error -2

Looks like stable material, right?

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx31.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
> index 8e19e70..1253af2 100644
> --- a/arch/arm/mach-imx/clk-imx31.c
> +++ b/arch/arm/mach-imx/clk-imx31.c
> @@ -130,7 +130,7 @@ int __init mx31_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[nfc], NULL, "mxc_nand.0");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "ipu-core");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
> -	clk_register_clkdev(clk[kpp_gate], "kpp", NULL);
> +	clk_register_clkdev(clk[kpp_gate], NULL, "imx-keypad");
>  	clk_register_clkdev(clk[usb_div_post], "per", "mxc-ehci.0");
>  	clk_register_clkdev(clk[usb_gate], "ahb", "mxc-ehci.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.0");
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
