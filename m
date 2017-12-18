From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 18 Dec 2017 09:47:11 +0530
Subject: [PATCH v7 1/6] dmaengine: xilinx_dma: Check for channel idle
 state before submitting dma descriptor
In-Reply-To: <1512624067-13554-2-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
 <1512624067-13554-2-git-send-email-appanad@xilinx.com>
Message-ID: <20171218041711.GN18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 10:51:02AM +0530, Kedareswara rao Appana wrote:

> @@ -2029,6 +2006,7 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
>  
>  	/* Remove and free all of the descriptors in the lists */
>  	xilinx_dma_free_descriptors(chan);
> +	chan->idle = true;
>  
>  	if (chan->cyclic) {
>  		reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
> @@ -2344,6 +2322,12 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  	chan->has_sg = xdev->has_sg;
>  	chan->desc_pendingcount = 0x0;
>  	chan->ext_addr = xdev->ext_addr;
> +	/* This variable enusres that descripotrs are not
				      ^^^^^^^^^^

typo

-- 
~Vinod
