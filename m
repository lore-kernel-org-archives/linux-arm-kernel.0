From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 17:13:34 +0200
Subject: [PATCH 3/6] dma: mmp_pdma: Simplify access to channel drcmr value
In-Reply-To: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397574817-15559-4-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the physical channel and virtual channel point to each other,
pchan->phy->vchan is always equal to pchan. Simplify the code
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/mmp_pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index b439679..643f225 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -277,7 +277,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 		return;
 
 	/* clear the channel mapping in DRCMR */
-	reg = DRCMR(pchan->phy->vchan->drcmr);
+	reg = DRCMR(pchan->drcmr);
 	writel(0, pchan->phy->base + reg);
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
-- 
1.8.3.2
