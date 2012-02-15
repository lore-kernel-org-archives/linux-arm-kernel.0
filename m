From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Feb 2012 13:16:35 -0700
Subject: [PATCH v2 7/7] ARM: imx: remove macro MXC_GPIO_IRQ_START
In-Reply-To: <1329331668-30325-8-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
 <1329331668-30325-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120215201635.GG25779@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 10:47:48AM -0800, Shawn Guo wrote:
> Now, macro MXC_GPIO_IRQ_START is referenced nowhere, so remove it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Series looks okay to me on a brief review.  I'll let Rob pick it up since
it needs to be based on top of his generic_irq work.  There will still need
to be some rebasing while I stablize the irq_domain tree, but I'll try to
do that ASAP.

g.

> ---
>  arch/arm/plat-mxc/include/mach/irqs.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> index fd9efb0..612fcf1 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -28,8 +28,6 @@
>  #define MXC_INTERNAL_IRQS	64
>  #endif
>  
> -#define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
> -
>  /*
>   * The next 16 interrupts are for board specific purposes.  Since
>   * the kernel can only run on one machine at a time, we can re-use
> -- 
> 1.7.5.4
> 
