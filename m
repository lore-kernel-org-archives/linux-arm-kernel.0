From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 24 Jan 2014 17:23:08 +0900
Subject: [PATCH] arm64: fix build error if DMA_CMA is enabled
Message-ID: <1390551788-6138-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64/include/asm/dma-contiguous.h is trying to include
<asm-genric/dma-contiguous.h> which does not exist, and thus failing
build for arm64 if we enable CONFIG_DMA_CMA. This patch fixes build 
error by removing unwanted header inclusion from arm64's dma-contiguous.h.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Somraj Mani <somraj.mani@samsung.com>
---
 arch/arm64/include/asm/dma-contiguous.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/dma-contiguous.h b/arch/arm64/include/asm/dma-contiguous.h
index d6aacb6..14c4c0c 100644
--- a/arch/arm64/include/asm/dma-contiguous.h
+++ b/arch/arm64/include/asm/dma-contiguous.h
@@ -18,7 +18,6 @@
 #ifdef CONFIG_DMA_CMA
 
 #include <linux/types.h>
-#include <asm-generic/dma-contiguous.h>
 
 static inline void
 dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
-- 
1.7.10.4
