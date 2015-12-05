From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 5 Dec 2015 15:38:04 +0530
Subject: [PATCH] dmaengine: bcm2835-dma: Convert to use DMA pool
In-Reply-To: <1447672143-14201-1-git-send-email-peter.ujfalusi@ti.com>
References: <1447672143-14201-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151205100804.GY1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 01:09:03PM +0200, Peter Ujfalusi wrote:
> f93178291712 dmaengine: bcm2835-dma: Fix memory leak when stopping a
> 	     running transfer
> 
> Fixed the memleak, but introduced another issue: the terminate_all callback
> might be called with interrupts disabled and the dma_free_coherent() is
> not allowed to be called when IRQs are disabled.
> Convert the driver to use dma_pool_* for managing the list of control
> blocks for the transfer.

Applied, thanks

-- 
~Vinod
