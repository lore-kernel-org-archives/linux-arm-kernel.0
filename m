From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 21:37:14 +0200
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine driver
 support
In-Reply-To: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
Message-ID: <4301925.4pMHXMXqA4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 October 2014 17:30:36 Srikanth Thokala wrote:
> @@ -15,6 +15,9 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  
> +/* Number of AXI DMA APP Words */
> +#define XILINX_DMA_NUM_APP_WORDS       5
> +
>  /**
>   * struct xilinx_vdma_config - VDMA Configuration structure
>   * @frm_dly: Frame delay
> @@ -41,7 +44,21 @@ struct xilinx_vdma_config {
>         int ext_fsync;
>  };
>  
> +/**
> + * struct xilinx_dma_config - DMA Configuration structure
> + * @coalesc: Interrupt coalescing threshold
> + * @delay: Delay counter
> + * @reset: Reset Channel
> + */
> +struct xilinx_dma_config {
> +       int coalesc;
> +       int delay;
> +       int reset;
> +};
> +
>  int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
>                                         struct xilinx_vdma_config *cfg);
> +int xilinx_dma_channel_set_config(struct dma_chan *dchan,
> +                                       struct xilinx_dma_config *cfg);
>  

You add this to a global header file, but I don't see any uses outside
of the driver itself. Please move all of this into the driver itself
and remove the header file.

	Arnd
