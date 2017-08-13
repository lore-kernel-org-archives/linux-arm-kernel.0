From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 13 Aug 2017 18:53:04 +0530
Subject: [PATCH] ste_dma40: make stedma40_chan_cfg const
Message-ID: <1502630584-6844-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/dma/ste_dma40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c3052fb..f4fab41 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -79,7 +79,7 @@
 };
 
 /* Default configuration for physcial memcpy */
-static struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
+static const struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
 	.mode = STEDMA40_MODE_PHYSICAL,
 	.dir = DMA_MEM_TO_MEM,
 
@@ -93,7 +93,7 @@
 };
 
 /* Default configuration for logical memcpy */
-static struct stedma40_chan_cfg dma40_memcpy_conf_log = {
+static const struct stedma40_chan_cfg dma40_memcpy_conf_log = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = DMA_MEM_TO_MEM,
 
-- 
1.9.1
