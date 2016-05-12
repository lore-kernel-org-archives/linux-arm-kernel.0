From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 12 May 2016 21:39:50 +0530
Subject: [RESEND PATCH v4 1/3] dmaengine: vdma: Add config structure to
 differentiate dmas
In-Reply-To: <1463046228-21651-2-git-send-email-appanad@xilinx.com>
References: <1463046228-21651-1-git-send-email-appanad@xilinx.com>
 <1463046228-21651-2-git-send-email-appanad@xilinx.com>
Message-ID: <20160512160950.GF2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 03:13:46PM +0530, Kedareswara rao Appana wrote:
> This patch adds config structure in the driver to differentiate
> AXI DMA's and to add more features(clock support etc..) to these DMA's.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_vdma.c | 83 ++++++++++++++++++++++++----------------
>  1 file changed, 51 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
> index 626939b..1d50e05 100644
> --- a/drivers/dma/xilinx/xilinx_vdma.c
> +++ b/drivers/dma/xilinx/xilinx_vdma.c
> @@ -342,6 +342,10 @@ struct xilinx_dma_chan {
>  	void (*start_transfer)(struct xilinx_dma_chan *chan);
>  };
>  
> +struct dma_config {

xilinx_dma_config ?

This makes reader believe that thismight be coething related to dmaengine
core

>  static const struct of_device_id xilinx_dma_of_ids[] = {
> -	{ .compatible = "xlnx,axi-dma-1.00.a",
> -	  .data = (void *)XDMA_TYPE_AXIDMA },
> -	{ .compatible = "xlnx,axi-cdma-1.00.a",
> -	  .data = (void *)XDMA_TYPE_CDMA },
> -	{ .compatible = "xlnx,axi-vdma-1.00.a",
> -	  .data = (void *)XDMA_TYPE_VDMA },
> +	{ .compatible = "xlnx,axi-dma-1.00.a", .data = &axidma_config },
> +	{ .compatible = "xlnx,axi-cdma-1.00.a", .data = &axicdma_config },
> +	{ .compatible = "xlnx,axi-vdma-1.00.a", .data = &axivdma_config },

why do we want a struct for this and not pass XDMA_TYPE_xxx as .data

-- 
~Vinod
