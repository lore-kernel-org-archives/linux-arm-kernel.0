From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:39 +0200
Subject: [PATCH 24/44] x86: remove DMA_ERROR_CODE
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-25-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All dma_map_ops instances now handle their errors through
->mapping_error.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 08a0838b83fb..c35d228aa381 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -19,8 +19,6 @@
 # define ISA_DMA_BIT_MASK DMA_BIT_MASK(32)
 #endif
 
-#define DMA_ERROR_CODE	0
-
 extern int iommu_merge;
 extern struct device x86_dma_fallback_dev;
 extern int panic_on_overflow;
-- 
2.11.0
