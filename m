From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 28 Nov 2011 09:12:57 +0530
Subject: [PATCH] dma i.MX: remove individual SOC dependency
In-Reply-To: <1321958598-27260-1-git-send-email-s.hauer@pengutronix.de>
References: <1321958598-27260-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1322451777.1516.979.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-22 at 11:43 +0100, Sascha Hauer wrote:
> The individual SoC dependency in Kconfig hardly scales anymore.
> Instead of having such a fine grained dependency just depend
> on ARCH_MXC and risk that the uninformed user has to look in
> the help text to figure out which driver is the correct one.
Not sure why it was resent but this already in my tree

commit 8e2d41f8c85613a3739e8b2600ac2c66c08422f3
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Wed Aug 24 08:41:09 2011 +0200

    dma i.MX: remove individual SOC dependency
    
    The individual SoC dependency in Kconfig hardly scales anymore.
    Instead of having such a fine grained dependency just depend
    on ARCH_MXC and risk that the uninformed user has to look in
    the help text to figure out which driver is the correct one.
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
    Cc: Vinod Koul <vinod.koul@intel.com>
    Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> ---
>  drivers/dma/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ab8f469..e514c45 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -124,7 +124,7 @@ config MV_XOR
>  
>  config MX3_IPU
>  	bool "MX3x Image Processing Unit support"
> -	depends on ARCH_MX3
> +	depends on ARCH_MXC
>  	select DMA_ENGINE
>  	default y
>  	help
> @@ -216,11 +216,11 @@ config PCH_DMA
>  
>  config IMX_SDMA
>  	tristate "i.MX SDMA support"
> -	depends on ARCH_MX25 || ARCH_MX3 || ARCH_MX5
> +	depends on ARCH_MXC
>  	select DMA_ENGINE
>  	help
>  	  Support the i.MX SDMA engine. This engine is integrated into
> -	  Freescale i.MX25/31/35/51 chips.
> +	  Freescale i.MX25/31/35/51/53 chips.
>  
>  config IMX_DMA
>  	tristate "i.MX DMA support"


-- 
~Vinod
