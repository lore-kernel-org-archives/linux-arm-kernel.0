From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 31 Oct 2013 19:06:50 +0530
Subject: [PATCH] dmaengine: imx-dma: fix format warnings
In-Reply-To: <E1VbgJK-0006iu-9m@rmk-PC.arm.linux.org.uk>
References: <E1VbgJK-0006iu-9m@rmk-PC.arm.linux.org.uk>
Message-ID: <20131031133650.GG18788@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:40:30AM +0000, Russell King wrote:
> drivers/dma/imx-dma.c:575:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:575:3: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:589:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:599:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:929:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:929:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:959:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> drivers/dma/imx-dma.c:959:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> 
> We can't use the %pa format for these because this relates to phys_addr_t,
> and dma_addr_t can be a different size.  So, fix these by converting them
> to %llx and casting the dma_addr_t to always be unsigned long long.
> 
> While we're here, also use %zu for size_t.

Applied, thanks

--
~Vinod
