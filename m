From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 30 Jun 2016 09:56:53 +0530
Subject: [PATCH v11 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <1465486667-30737-2-git-send-email-appanad@xilinx.com>
References: <1465486667-30737-1-git-send-email-appanad@xilinx.com>
 <1465486667-30737-2-git-send-email-appanad@xilinx.com>
Message-ID: <20160630042653.GM14945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 09:07:47PM +0530, Kedareswara rao Appana wrote:

> +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
> +	dma_cap_set(DMA_SG, zdev->common.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, zdev->common.cap_mask);
 
>  /**
> + * struct zynqmp_dma_config - ZYNQMP DMA Configuration structure
> + * @ovrfetch: Overfetch status
> + * @has_sg: Support scatter gather transfers
> + * @ratectrl: Rate control value
> + * @src_issue: Out standing transactions on source
> + * @src_burst_len: Source burst length
> + * @dst_burst_len: Dest burst length
> + */

As discussed in other thread as well, this is no-go for memcpy. Please come
back after removing this

For slave usages use the dma_slave_config

-- 
~Vinod
