From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 23:37:12 +0800
Subject: [PATCH v2 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <1341898587-8462-6-git-send-email-shawn.guo@linaro.org>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <1341898587-8462-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120710153710.GB11813@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 01:36:25PM +0800, Shawn Guo wrote:
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index d0bf414..c1e02ae 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -12,8 +12,9 @@
>  
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/init.h>
> +#include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/irqdomain.h>
>  #include <linux/micrel_phy.h>
> @@ -24,6 +25,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <mach/common.h>
> +#include <mach/mxs.h>
>  
With tx28_init dropped, these header changes shouldn't be here any more.

Regards,
Shawn

>  static struct fb_videomode mx23evk_video_modes[] = {
>  	{
> @@ -277,6 +279,7 @@ static const char *imx28_dt_compat[] __initdata = {
>  	"crystalfontz,cfa10036",
>  	"denx,m28evk",
>  	"fsl,imx28-evk",
> +	"karo,tx28",
>  	"fsl,imx28",
>  	NULL,
>  };
> -- 
> 1.7.5.4
> 
> 
