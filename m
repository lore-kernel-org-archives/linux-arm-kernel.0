From: joe@perches.com (Joe Perches)
Date: Mon, 30 Mar 2015 16:46:00 -0700
Subject: [PATCH 02/25] arm64: Use bool function return values of true/false
 not 1/0
In-Reply-To: <cover.1427759009.git.joe@perches.com>
References: <cover.1427759009.git.joe@perches.com>
Message-ID: <4e68cc1c7021725e529b0190ff35fa26099b57c5.1427759009.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm64/include/asm/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 6932bb5..9437e3d 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -97,7 +97,7 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
-		return 0;
+		return false;
 
 	return addr + size - 1 <= *dev->dma_mask;
 }
-- 
2.1.2
