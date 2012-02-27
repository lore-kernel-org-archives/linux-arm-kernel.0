From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Feb 2012 10:24:05 +0100
Subject: [PATCH] ARM: mach-imx: mx3: Fix section mismatch in
 imx3_init_l2x0()
In-Reply-To: <1330273624-5757-1-git-send-email-festevam@gmail.com>
References: <1330273624-5757-1-git-send-email-festevam@gmail.com>
Message-ID: <20120227092405.GW3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 01:27:04PM -0300, Fabio Estevam wrote:
> Fix the following section mismatch:
> 
> WARNING: vmlinux.o(.text+0x11be8): Section mismatch in reference from the function imx3_init_l2x0() to the function .init.text:l2x0_init()
> The function imx3_init_l2x0() references
> the function __init l2x0_init().
> This is often because imx3_init_l2x0 lacks a __init 
> annotation or the annotation of l2x0_init is wrong.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied

Sascha

> ---
>  arch/arm/mach-imx/mm-imx3.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index 8404ee7..6222151 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -76,7 +76,7 @@ static void __iomem *imx3_ioremap(unsigned long phys_addr, size_t size,
>  	return __arm_ioremap(phys_addr, size, mtype);
>  }
>  
> -void imx3_init_l2x0(void)
> +void __init imx3_init_l2x0(void)
>  {
>  	void __iomem *l2x0_base;
>  	void __iomem *clkctl_base;
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
