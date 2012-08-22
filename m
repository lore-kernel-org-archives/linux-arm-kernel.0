From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Wed, 22 Aug 2012 09:15:22 +0530
Subject: [PATCH v2 3/3] spi: spi-davinci: convert to DMA engine API
In-Reply-To: <1345574589-24757-4-git-send-email-mporter@ti.com>
References: <1345574589-24757-1-git-send-email-mporter@ti.com>
 <1345574589-24757-4-git-send-email-mporter@ti.com>
Message-ID: <1345607122.1895.44.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-08-21 at 14:43 -0400, Matt Porter wrote:
> Removes use of the DaVinci EDMA private DMA API and replaces
> it with use of the DMA engine API.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---

> +		struct dma_slave_config dma_rx_conf = {
> +			.direction = DMA_DEV_TO_MEM,
> +			.src_addr = (unsigned long)dspi->pbase + SPIBUF,
> +			.src_addr_width = data_type,
> +			.src_maxburst = 1,
what does 1 mean in this context? We define as number of units that
needs to be transfered, so are you sure that you want only one unit to
be dma'ed in a single burst. that seems like killing your dmac,
shouldn't you be using larger bursts for a better dma performance?


-- 
~Vinod
