From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 17:14:56 +0100
Subject: [PATCH] dmaengine: bcm2835: fix unexported function
Message-ID: <1465316096-6025-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bcm2835_dma_prep_dma_memcpy() function is not exported
outside the driver, so make it static to avoid the following
warning:

drivers/dma/bcm2835-dma.c:616:32: warning: symbol 'bcm2835_dma_prep_dma_memcpy' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: dmaengine at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6149b27..9ecb942 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -613,7 +613,7 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
 
-struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
+static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 	size_t len, unsigned long flags)
 {
-- 
2.8.1
