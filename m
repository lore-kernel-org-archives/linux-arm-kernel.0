From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Jul 2016 10:03:46 +0530
Subject: [PATCH] dmaengine: zynqmp: avoid cast warning
In-Reply-To: <20160711214642.2610193-1-arnd@arndb.de>
References: <20160711214642.2610193-1-arnd@arndb.de>
Message-ID: <20160712043346.GO9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 11:46:09PM +0200, Arnd Bergmann wrote:
> The newly added zynqmp_dma driver produces a warning on 32-bit architectures
> when dma_addr_t is 64-bit wide:
> 
> drivers/dma/xilinx/zynqmp_dma.c: In function 'zynqmp_dma_config_sg_ll_desc':
> drivers/dma/xilinx/zynqmp_dma.c:321:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>         ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);
>          ^
> drivers/dma/xilinx/zynqmp_dma.c:321:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>         ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);
> 
> This changes the cast to the more appropriate uintptr_t.

Applied, thanks

-- 
~Vinod
