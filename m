From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:38 +0530
Subject: [PATCH 20/28] dmaengine: ppc4xx: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-21-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Anatolij Gustschin <agust@denx.de>
---
 drivers/dma/ppc4xx/adma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 370ff82..60e02ae 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -3891,7 +3891,7 @@ static enum dma_status ppc440spe_adma_tx_status(struct dma_chan *chan,
 
 	ppc440spe_chan = to_ppc440spe_adma_chan(chan);
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_SUCCESS)
+	if (ret == DMA_COMPLETE)
 		return ret;
 
 	ppc440spe_adma_slot_cleanup(ppc440spe_chan);
-- 
1.7.0.4
