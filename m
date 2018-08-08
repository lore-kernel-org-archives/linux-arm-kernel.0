From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 7 Aug 2018 19:07:35 -0500
Subject: [PATCH] dma/direct: Use true and false for boolean values
Message-ID: <20180808000735.GA7314@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/include/asm/dma-direct.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index b67e5fc..906fdcf 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -19,18 +19,18 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	u64 limit, mask;
 
 	if (!dev->dma_mask)
-		return 0;
+		return false;
 
 	mask = *dev->dma_mask;
 
 	limit = (mask + 1) & ~mask;
 	if (limit && size > limit)
-		return 0;
+		return false;
 
 	if ((addr | (addr + size - 1)) & ~mask)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 #endif /* ASM_ARM_DMA_DIRECT_H */
-- 
2.7.4
