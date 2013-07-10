From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 10 Jul 2013 22:30:53 +0800
Subject: [PATCH linux-next] ARM: imx: fix imx_init_l2cache storage class
In-Reply-To: <1373449546-1040-1-git-send-email-vincent.stehle@freescale.com>
References: <1373449546-1040-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <20130710143051.GA24654@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vincent,

Sorry.  I was not aware of that imx_v6_v7_defconfig does not have
CACHE_L2X0 enabled, so I did not catch it with my testing.  Thanks for
fixing it.

On Wed, Jul 10, 2013 at 11:45:46AM +0200, Vincent Stehl? wrote:
> Commit 879ec1ceeac21285d62606c1e96520887efcd9bc makes imx_init_l2cache a common
> function and updates the header declaration accordingly. Fix function storage
> class, too.
> 
The commit ID is not stable, and I dropped it and applied the patch.

Shawn

> This fixes the following compilation error:
> 
>   arch/arm/mach-imx/system.c:101:123: error: static declaration of ?imx_init_l2cache? follows non-static declaration
>   In file included from arch/arm/mach-imx/system.c:32:0:
>   arch/arm/mach-imx/common.h:165:13: note: previous declaration of ?imx_init_l2cache? was here
>   arch/arm/mach-imx/system.c:101:123: warning: ?imx_init_l2cache? defined but not used [-Wunused-function]
> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: trivial at kernel.org
> ---
> 
> 
> Hi,
> 
> Linux next-20130710 breaks compilation of ARM multi_v7_defconfig. This patch fixes it.
> 
> (Note: this patch is necessary for the link, too: http://www.spinics.net/lists/kernel/msg1563777.html)
> 
> Best regards,
> 
> V.
> 
> 
>  arch/arm/mach-imx/system.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> index e5592ca..64ff37e 100644
> --- a/arch/arm/mach-imx/system.c
> +++ b/arch/arm/mach-imx/system.c
> @@ -98,7 +98,7 @@ void __init mxc_arch_reset_init_dt(void)
>  }
>  
>  #ifdef CONFIG_CACHE_L2X0
> -static void __init imx_init_l2cache(void)
> +void __init imx_init_l2cache(void)
>  {
>  	void __iomem *l2x0_base;
>  	struct device_node *np;
> -- 
> 1.7.10.4
> 
> 
> 
