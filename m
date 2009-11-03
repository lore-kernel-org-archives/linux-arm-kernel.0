From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 3 Nov 2009 23:35:30 +0100
Subject: [PATCH]: Remove duplicate s3c_dma_has_circular() definition for
	S3C64xx.
Message-ID: <b2e8f9f70911031435x4da7d4fbuab22c453e7d02f64@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the duplicated s3c_dma_has_circular() definition and so fixes
compilation for S3C64xx.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

---
 arch/arm/mach-s3c6400/include/mach/dma.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/dma.h
b/arch/arm/mach-s3c6400/include/mach/dma.h
index 004edab..b7e5494 100644
--- a/arch/arm/mach-s3c6400/include/mach/dma.h
+++ b/arch/arm/mach-s3c6400/include/mach/dma.h
@@ -58,14 +58,6 @@ enum dma_ch {
 	DMACH_MAX		/* the end */
 };

-static __inline__ int s3c_dma_has_circular(void)
-{
-	/* we will be supporting ciruclar buffers as soon as we have DMA
-	 * engine support.
-	 */
-	return 1;
-}
-
 #define S3C2410_DMAF_CIRCULAR		(1 << 0)

 static inline bool s3c_dma_has_circular(void)
-- 
1.6.3.3
