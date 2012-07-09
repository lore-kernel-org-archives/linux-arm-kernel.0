From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Jul 2012 08:52:47 +0200
Subject: [PATCH] ARM: mx27: Reenable silicon version print
In-Reply-To: <1341612275-4464-1-git-send-email-festevam@gmail.com>
References: <1341612275-4464-1-git-send-email-festevam@gmail.com>
Message-ID: <20120709065247.GM30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 07:04:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Prior to the new i.mx clock conversion the mx27 silicon version was printed at boot.
> 
> Reenable this feature.

Applied, thanks.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx27.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
> index e8a6016..c9370bf 100644
> --- a/arch/arm/mach-imx/clk-imx27.c
> +++ b/arch/arm/mach-imx/clk-imx27.c
> @@ -269,6 +269,8 @@ int __init mx27_clocks_init(unsigned long fref)
>  
>  	clk_prepare_enable(clk[emi_ahb_gate]);
>  
> +	imx_print_silicon_rev("i.MX27", mx27_revision());
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
