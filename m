From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 23 Dec 2011 21:15:27 +0530
Subject: [PATCH v2 08/19] dma: MX3_IPU fix depends
In-Reply-To: <1323785575-22703-1-git-send-email-eric@eukrea.com>
References: <CAOMZO5AOpFtkJDmTSjPmvPVr0ra4d7jUcihGgncYE2VtfKCeSQ@mail.gmail.com>
 <1323785575-22703-1-git-send-email-eric@eukrea.com>
Message-ID: <1324655127.1633.4.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-13 at 15:12 +0100, Eric B?nard wrote:
> ARCH_MX3 was removed in commit a89cf59 :
> "arm/imx: merge i.MX3 and i.MX6"
> thus preventing to select MX3_IPU, thus preventing IPU and display
> to work on i.MX3x SOC.
> i.MX SDMA support is also affected.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
> v2: improve comment based on Sergei's comments, and also handle SDMA
> case based on Fabio's comment
>  drivers/dma/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ab8f469..5a99bb3 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -124,7 +124,7 @@ config MV_XOR
>  
>  config MX3_IPU
>  	bool "MX3x Image Processing Unit support"
> -	depends on ARCH_MX3
> +	depends on SOC_IMX31 || SOC_IMX35
>  	select DMA_ENGINE
>  	default y
>  	help
> @@ -216,7 +216,7 @@ config PCH_DMA
>  
>  config IMX_SDMA
>  	tristate "i.MX SDMA support"
> -	depends on ARCH_MX25 || ARCH_MX3 || ARCH_MX5
> +	depends on ARCH_MX25 || SOC_IMX31 || SOC_IMX35 || ARCH_MX5
>  	select DMA_ENGINE
>  	help
>  	  Support the i.MX SDMA engine. This engine is integrated into
Which tree is this targeted to?

-- 
~Vinod
