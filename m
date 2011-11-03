From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu,  3 Nov 2011 15:48:49 +0900
Subject: [PATCH] DMA: PL330: Fix build warning
Message-ID: <1320302929-4731-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to fix the build warning as following.

drivers/dma/pl330.c: In function 'pl330_probe':
drivers/dma/pl330.c:859: warning: comparison of distinct pointer types lacks a cast

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 drivers/dma/pl330.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 621134f..379d928 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -856,7 +856,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	INIT_LIST_HEAD(&pd->channels);
 
 	/* Initialize channel parameters */
-	num_chan = max(pdat ? pdat->nr_valid_peri : 0, (u8)pi->pcfg.num_chan);
+	num_chan = max(pdat ? (int)pdat->nr_valid_peri : 0,
+					(int)pi->pcfg.num_chan);
 	pdmac->peripherals = kzalloc(num_chan * sizeof(*pch), GFP_KERNEL);
 
 	for (i = 0; i < num_chan; i++) {
-- 
1.7.1
