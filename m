From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Feb 2013 10:45:20 +0100
Subject: [PATCH] ARM: imx27: clk-imx27: SPI: Rename IPG clock and add PER
 clock
In-Reply-To: <1359209221-24346-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1359209221-24346-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130205094520.GW1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 03:07:01PM +0100, Gwenhael Goavec-Merou wrote:
> spi-imx driver needs two clock: ipg and per. The first clock must be named and
> the second must be added.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/clk-imx27.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
> index 4c1d1e4..c599839 100644
> --- a/arch/arm/mach-imx/clk-imx27.c
> +++ b/arch/arm/mach-imx/clk-imx27.c
> @@ -228,9 +228,12 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "imx21-mmc.1");
>  	clk_register_clkdev(clk[per2_gate], "per", "imx21-mmc.2");
>  	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "imx21-mmc.2");
> -	clk_register_clkdev(clk[cspi1_ipg_gate], NULL, "imx27-cspi.0");
> -	clk_register_clkdev(clk[cspi2_ipg_gate], NULL, "imx27-cspi.1");
> -	clk_register_clkdev(clk[cspi3_ipg_gate], NULL, "imx27-cspi.2");
> +	clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.0");
> +	clk_register_clkdev(clk[cspi1_ipg_gate], "ipg", "imx27-cspi.0");
> +	clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.1");
> +	clk_register_clkdev(clk[cspi2_ipg_gate], "ipg", "imx27-cspi.1");
> +	clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.2");
> +	clk_register_clkdev(clk[cspi3_ipg_gate], "ipg", "imx27-cspi.2");
>  	clk_register_clkdev(clk[per3_gate], "per", "imx21-fb.0");
>  	clk_register_clkdev(clk[lcdc_ipg_gate], "ipg", "imx21-fb.0");
>  	clk_register_clkdev(clk[lcdc_ahb_gate], "ahb", "imx21-fb.0");
> -- 
> 1.7.12.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
