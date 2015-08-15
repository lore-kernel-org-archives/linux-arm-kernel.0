From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 15 Aug 2015 17:52:51 +0200
Subject: [PATCH] arm: dma-mapping: add cast to DMA_ERROR_CODE
Message-ID: <1439653971-867-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the compiler warning

./arch/arm/include/asm/dma-mapping.h: In function ?dma_mapping_error?:
./arch/arm/include/asm/dma-mapping.h:176:18: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  return dma_addr == DMA_ERROR_CODE;
                  ^

we get building the kernel with W=1.

This is done the same way we have already in the arm64 version.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
 arch/arm/include/asm/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index b52101d..68e41e8 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -14,7 +14,7 @@
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
-#define DMA_ERROR_CODE	(~0)
+#define DMA_ERROR_CODE	(~(dma_addr_t)0)
 extern struct dma_map_ops arm_dma_ops;
 extern struct dma_map_ops arm_coherent_dma_ops;
 
-- 
2.5.0
