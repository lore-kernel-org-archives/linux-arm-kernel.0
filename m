From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Aug 2012 09:45:51 +0200
Subject: [PATCH v2 2/2] ARM: clk-imx25: Fix SSI clock registration
In-Reply-To: <1345395959-26978-1-git-send-email-festevam@gmail.com>
References: <1345395959-26978-1-git-send-email-festevam@gmail.com>
Message-ID: <20120828074551.GW26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 19, 2012 at 02:05:59PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> SSI block has two types of clock:
> 
> ipg: bus clock, the clock needed for accessing registers.
> per: peripheral clock, the clock needed for generating the bit rate.
> 
> Currently SSI driver only supports slave mode and only need to handle
> the ipg clock, because the peripheral clock comes from the master codec.
> 
> Only register the ipg clock and do not register the peripheral clock for ssi.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied and also added stable tag.

Sascha

> ---
> Changes since v1:
> - Use imx-ssi.1 for ssi2_ipg
> 
>  arch/arm/mach-imx/clk-imx25.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
> index fdd8cc8..5ff9534 100644
> --- a/arch/arm/mach-imx/clk-imx25.c
> +++ b/arch/arm/mach-imx/clk-imx25.c
> @@ -222,10 +222,8 @@ int __init mx25_clocks_init(void)
>  	clk_register_clkdev(clk[lcdc_ipg], "ipg", "imx-fb.0");
>  	clk_register_clkdev(clk[lcdc_ahb], "ahb", "imx-fb.0");
>  	clk_register_clkdev(clk[wdt_ipg], NULL, "imx2-wdt.0");
> -	clk_register_clkdev(clk[ssi1_ipg_per], "per", "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi1_ipg], "ipg", "imx-ssi.0");
> -	clk_register_clkdev(clk[ssi2_ipg_per], "per", "imx-ssi.1");
> -	clk_register_clkdev(clk[ssi2_ipg], "ipg", "imx-ssi.1");
> +	clk_register_clkdev(clk[ssi1_ipg], NULL, "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi2_ipg], NULL, "imx-ssi.1");
>  	clk_register_clkdev(clk[esdhc1_ipg_per], "per", "sdhci-esdhc-imx25.0");
>  	clk_register_clkdev(clk[esdhc1_ipg], "ipg", "sdhci-esdhc-imx25.0");
>  	clk_register_clkdev(clk[esdhc1_ahb], "ahb", "sdhci-esdhc-imx25.0");
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
