From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Feb 2018 13:55:36 +0000
Subject: [PATCH] crypto: marvell/cesa - Clean up redundant #include
Message-ID: <99d8deb60039adf572aec26b091f2b0c61edf397.1519048413.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of dma-direct.h was only needed temporarily to prevent
breakage from the DMA API rework, since the actual CESA fix making it
redundant was merged in parallel. Now that both have landed, it can go.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/crypto/marvell/cesa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index aca2373fa1de..f81fa4a3e66b 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -25,7 +25,6 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/dma-direct.h> /* XXX: drivers shall never use this directly! */
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-- 
2.16.1.dirty
