From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 16 Mar 2012 08:43:57 +0530
Subject: [PATCH 1/6] dmaengine: Kconfig: fix Atmel at_hdmac entry
In-Reply-To: <7cdf1e94a17a7d872cb1eeaef812aab25b3caf40.1331826095.git.nicolas.ferre@atmel.com>
References: <cover.1331826095.git.nicolas.ferre@atmel.com>
 <7cdf1e94a17a7d872cb1eeaef812aab25b3caf40.1331826095.git.nicolas.ferre@atmel.com>
Message-ID: <1331867637.1727.29.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-15 at 16:57 +0100, Nicolas Ferre wrote:
> Remove SoC dependency and make it generic for every Atmel ARM AT91. That will
> allow to select this driver for newer chips. Keep dependency on AT91 because of
> the use of an header file located in include/mach directory.
> Modify the comment to reflect this.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>
> ---
>  drivers/dma/Kconfig |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index f1a2749..6d50f35 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -91,11 +91,10 @@ config DW_DMAC
>  
>  config AT_HDMAC
>  	tristate "Atmel AHB DMA support"
> -	depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
> +	depends on ARCH_AT91
>  	select DMA_ENGINE
>  	help
> -	  Support the Atmel AHB DMA controller.  This can be integrated in
> -	  chips such as the Atmel AT91SAM9RL.
> +	  Support the Atmel AHB DMA controller.
>  
>  config FSL_DMA
>  	tristate "Freescale Elo and Elo Plus DMA support"


-- 
~Vinod
