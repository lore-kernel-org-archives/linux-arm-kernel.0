From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  8 Jul 2015 16:28:17 +0200
Subject: [PATCHv4 4/6] dmaengine: mv_xor: remove mv_xor_chan->current_type
 field
In-Reply-To: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1436365699-6862-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 3e4f52e2da9f6 ("dma: mv_xor: Simplify the DMA_MEMCPY
operation"), this field is no longer used, so get rid of it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/mv_xor.c | 1 -
 drivers/dma/mv_xor.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 6aedc36..1fe3e33 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -169,7 +169,6 @@ static void mv_chan_set_mode(struct mv_xor_chan *chan,
 #endif
 
 	writel_relaxed(config, XOR_CONFIG(chan));
-	chan->current_type = type;
 }
 
 static void mv_chan_set_mode_to_desc(struct mv_xor_chan *chan)
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 41a2e8d..c19fe30 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -110,7 +110,6 @@ struct mv_xor_chan {
 	void __iomem		*mmr_high_base;
 	unsigned int		idx;
 	int                     irq;
-	enum dma_transaction_type	current_type;
 	struct list_head	chain;
 	struct list_head	free_slots;
 	struct list_head	allocated_slots;
-- 
2.4.5
