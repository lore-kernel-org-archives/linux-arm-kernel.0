From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 28 Oct 2013 19:54:14 -0300
Subject: [PATCH 1/2] dma: mv_xor: Remove unneeded NULL address check
Message-ID: <1383000855-8377-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mmio address is checked at probe-time, which makes this test
redundant. Let's just remove it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/dma/mv_xor.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 536dcb8..d00d58e 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1076,10 +1076,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	}
 
 	mv_chan->mmr_base = xordev->xor_base;
-	if (!mv_chan->mmr_base) {
-		ret = -ENOMEM;
-		goto err_free_dma;
-	}
 	tasklet_init(&mv_chan->irq_tasklet, mv_xor_tasklet, (unsigned long)
 		     mv_chan);
 
-- 
1.8.1.5
