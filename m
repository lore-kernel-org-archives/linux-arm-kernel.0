From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jan 2010 18:57:53 +0100
Subject: [PATCH] mx2/mx3: debug-macro.S needs deprecated symbols
In-Reply-To: <1264440184-1740-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1264440184-1740-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100126175753.GE19551@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 06:23:04PM +0100, Uwe Kleine-K?nig wrote:
> This fixes:
> 
> 	arch/arm/kernel/debug.S:147: Error: constant expression expected -- `ldrne r3,=(((UART1_BASE_ADDR)-AIPI_BASE_ADDR)+AIPI_BASE_ADDR_VIRT)'
> 	arch/arm/kernel/debug.S:163: Error: constant expression expected -- `ldrne r3,=(((UART1_BASE_ADDR)-AIPI_BASE_ADDR)+AIPI_BASE_ADDR_VIRT)'
> 
> when compiling for mx2 with CONFIG_DEBUG_LL=y.  A similar error exists
> on mx3 and is fixed by this commit, too.

Ok, added to mxc-master.

Sascha

> 
> These were introduced by aae7019382896cf1075a93acc564e42601bc44a2.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> the offending commit is currently in mxc-master but not yet in rmk's
> tree.
> 
> Best regards
> Uwe
> 
>  arch/arm/plat-mxc/include/mach/debug-macro.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> index 15b2b14..21e0f07 100644
> --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> @@ -10,6 +10,7 @@
>   * published by the Free Software Foundation.
>   *
>   */
> +#define IMX_NEEDS_DEPRECATED_SYMBOLS
>  
>  #ifdef CONFIG_ARCH_MX1
>  #include <mach/mx1.h>
> -- 
> 1.6.6
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
