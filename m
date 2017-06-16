From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 20:10:25 +0200
Subject: [PATCH 10/44] ia64: remove DMA_ERROR_CODE
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <20170616181059.19206-11-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All ia64 dma_mapping_ops instances already have a mapping_error member.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 73ec3c6f4cfe..3ce5ab4339f3 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -12,8 +12,6 @@
 
 #define ARCH_HAS_DMA_GET_REQUIRED_MASK
 
-#define DMA_ERROR_CODE 0
-
 extern const struct dma_map_ops *dma_ops;
 extern struct ia64_machine_vector ia64_mv;
 extern void set_iommu_machvec(void);
-- 
2.11.0
