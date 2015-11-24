From: eric@anholt.net (Eric Anholt)
Date: Tue, 24 Nov 2015 10:34:13 -0800
Subject: [PATCH] dmaengine: bcm2835-dma: Convert to use DMA pool
In-Reply-To: <1447672143-14201-1-git-send-email-peter.ujfalusi@ti.com>
References: <1447672143-14201-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <87poyztffe.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> f93178291712 dmaengine: bcm2835-dma: Fix memory leak when stopping a
> 	     running transfer
>
> Fixed the memleak, but introduced another issue: the terminate_all callback
> might be called with interrupts disabled and the dma_free_coherent() is
> not allowed to be called when IRQs are disabled.
> Convert the driver to use dma_pool_* for managing the list of control
> blocks for the transfer.
>
> Fixes: f93178291712 ("dmaengine: bcm2835-dma: Fix memory leak when stopping a running transfer")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

It sounds like you got positive testing feedback.  Using the DMA pool
for our bcm2835_dma_cbs makes sense to me, too.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/938864d8/attachment.sig>
