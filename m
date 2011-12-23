From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Dec 2011 16:23:33 +0000
Subject: [PATCH 1/2] ARM: SAMSUNG: Guard against multiple inclusion of
 plat/dma.h
Message-ID: <1324657414-27991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise it'll generate errors if included twice.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/include/plat/dma.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-samsung/include/plat/dma.h
index b906112..baa05ed 100644
--- a/arch/arm/plat-samsung/include/plat/dma.h
+++ b/arch/arm/plat-samsung/include/plat/dma.h
@@ -10,6 +10,9 @@
  * published by the Free Software Foundation.
 */
 
+#ifndef __PLAT_DMA_H
+#define __PLAT_DMA_H
+
 #include <linux/dma-mapping.h>
 
 enum s3c2410_dma_buffresult {
@@ -124,3 +127,5 @@ extern int s3c2410_dma_set_buffdone_fn(enum dma_ch, s3c2410_dma_cbfn_t rtn);
 
 
 #include <plat/dma-ops.h>
+
+#endif
-- 
1.7.7.3
