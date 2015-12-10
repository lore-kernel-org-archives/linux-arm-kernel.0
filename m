From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 10 Dec 2015 09:45:44 +0530
Subject: [PATCH v2] dmaengine: stm32-dma: Fix unchecked deference of
 chan->desc
In-Reply-To: <1449486028-29344-1-git-send-email-cedric.madianga@gmail.com>
References: <1449486028-29344-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20151210041544.GO1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 12:00:28PM +0100, M'boumba Cedric Madianga wrote:
> 'commit d8b468394fb7 ("dmaengine: Add STM32 DMA driver")' leads to the
> following Smatch complaint:
> 
> drivers/dma/stm32-dma.c:562 stm32_dma_issue_pending()
>     error: we previously assumed 'chan->desc' could be null (see line 560)
> 
> So, this patch fixes the unchecked dereference of chan->desc by returning
> operation not permitted error when stm32_dma_start_transfer() does not
> succeed to allocate a virtual channel descriptor.

Applied, thanks

-- 
~Vinod
