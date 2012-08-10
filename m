From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 10 Aug 2012 21:19:37 +0200
Subject: [PATCH] ARM: plat-mxc: Remove unused imx_ioremap
In-Reply-To: <1344431176-10486-1-git-send-email-festevam@gmail.com>
References: <1344431176-10486-1-git-send-email-festevam@gmail.com>
Message-ID: <20120810191937.GE1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 10:06:16AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx_ioremap is no longer used on imx platforms, so remove it.
> 
> As the EXPORT_SYMBOL_GPL is removed, it is also safe to remove the module.h header.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/plat-mxc/system.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
> index 1996c3e..3da78cf 100644
> --- a/arch/arm/plat-mxc/system.c
> +++ b/arch/arm/plat-mxc/system.c
> @@ -21,7 +21,6 @@
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> -#include <linux/module.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/common.h>
> @@ -29,9 +28,6 @@
>  #include <asm/proc-fns.h>
>  #include <asm/mach-types.h>
>  
> -void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
> -EXPORT_SYMBOL_GPL(imx_ioremap);
> -
>  static void __iomem *wdog_base;
>  
>  /*
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
