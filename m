From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Jul 2012 23:27:05 +0200
Subject: [PATCH 2/2] ARM: imx: clk-imx31: Fix clock id for rnga driver
In-Reply-To: <1341606020-26449-2-git-send-email-fabio.estevam@freescale.com>
References: <1341606020-26449-1-git-send-email-fabio.estevam@freescale.com>
 <1341606020-26449-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120716212705.GV30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 05:20:20PM -0300, Fabio Estevam wrote:
> Fix clock id for rnga driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied (only this one)

Thanks,
  Sascha

> ---
>  arch/arm/mach-imx/clk-imx31.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
> index c9a06d8..8a7ef99 100644
> --- a/arch/arm/mach-imx/clk-imx31.c
> +++ b/arch/arm/mach-imx/clk-imx31.c
> @@ -165,7 +165,7 @@ int __init mx31_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[firi_gate], "firi", NULL);
>  	clk_register_clkdev(clk[ata_gate], NULL, "pata_imx");
>  	clk_register_clkdev(clk[rtic_gate], "rtic", NULL);
> -	clk_register_clkdev(clk[rng_gate], "rng", NULL);
> +	clk_register_clkdev(clk[rng_gate], NULL, "mxc_rnga");
>  	clk_register_clkdev(clk[sdma_gate], NULL, "imx31-sdma");
>  	clk_register_clkdev(clk[iim_gate], "iim", NULL);
>  
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
