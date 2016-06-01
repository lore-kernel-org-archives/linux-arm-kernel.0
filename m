From: sr@denx.de (Stefan Roese)
Date: Wed,  1 Jun 2016 12:43:31 +0200
Subject: [PATCH 1/2] dmaengine: mv_xor: Minor coding style fix
Message-ID: <20160601104332.12212-1-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the space before the "err_free_dma:" label in mv_xor_channel_add().

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 25d1dad..55815c1 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1055,7 +1055,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 err_free_irq:
 	free_irq(mv_chan->irq, mv_chan);
- err_free_dma:
+err_free_dma:
 	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 	return ERR_PTR(ret);
-- 
2.8.3
