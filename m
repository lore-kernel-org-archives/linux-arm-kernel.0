From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Jul 2013 10:11:47 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: BOCK-W: enable DMA for SDHI0
In-Reply-To: <201307230223.24954.sergei.shtylyov@cogentembedded.com>
References: <201307230218.01495.sergei.shtylyov@cogentembedded.com>
 <201307230223.24954.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130723011147.GA17885@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 02:23:24AM +0400, Sergei Shtylyov wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
> driver.
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: removed #include <mach/dma.h>]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I don't see HPBDMA_SLAVE_SDHI0_TX in v3.11-rc2.
Please repost this patch when it is available in
a branch I can used as a base.

> 
> ---
> Changes in version 2:
> - removed #include <mach/dma.h>;
> - refreshed the patch.
> 
>  arch/arm/mach-shmobile/board-bockw.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: renesas/arch/arm/mach-shmobile/board-bockw.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
> +++ renesas/arch/arm/mach-shmobile/board-bockw.c
> @@ -81,6 +81,8 @@ static struct rcar_phy_platform_data usb
>  
>  /* SDHI */
>  static struct sh_mobile_sdhi_info sdhi0_info = {
> +	.dma_slave_tx	= HPBDMA_SLAVE_SDHI0_TX,
> +	.dma_slave_rx	= HPBDMA_SLAVE_SDHI0_RX,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
>  	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
> 
