From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 4 Nov 2009 13:13:29 +0100
Subject: [PATCHv2]: Remove duplicate s3c_dma_has_circular() definition for
	S3C64xx.
Message-ID: <b2e8f9f70911040413l5ca1280ds1481b008e1564196@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the duplicated s3c_dma_has_circular() definition and so fixes
compilation for S3C64xx.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

---
 arch/arm/mach-s3c6400/include/mach/dma.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/dma.h
b/arch/arm/mach-s3c6400/include/mach/dma.h
index 004edab..1067619 100644
--- a/arch/arm/mach-s3c6400/include/mach/dma.h
+++ b/arch/arm/mach-s3c6400/include/mach/dma.h
@@ -68,11 +68,6 @@ static __inline__ int s3c_dma_has_circular(void)

 #define S3C2410_DMAF_CIRCULAR		(1 << 0)

-static inline bool s3c_dma_has_circular(void)
-{
-	return false;
-}
-
 #include <plat/dma.h>

 #endif /* __ASM_ARCH_IRQ_H */
-- 
1.6.3.3
