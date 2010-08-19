From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 19 Aug 2010 16:40:00 +0200 (CEST)
Subject: [PATCH 1/5] DMA: Remove unneeded "extern" from function declarations
In-Reply-To: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
Message-ID: <Pine.LNX.4.64.1008191632260.26145@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/asm-generic/dma-coherent.h |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/dma-coherent.h b/include/asm-generic/dma-coherent.h
index 85a3ffa..a92bc09 100644
--- a/include/asm-generic/dma-coherent.h
+++ b/include/asm-generic/dma-coherent.h
@@ -14,15 +14,12 @@ int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
  * Standard interface
  */
 #define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
-extern int
-dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 			    dma_addr_t device_addr, size_t size, int flags);
 
-extern void
-dma_release_declared_memory(struct device *dev);
+void dma_release_declared_memory(struct device *dev);
 
-extern void *
-dma_mark_declared_memory_occupied(struct device *dev,
+void *dma_mark_declared_memory_occupied(struct device *dev,
 				  dma_addr_t device_addr, size_t size);
 #else
 #define dma_alloc_from_coherent(dev, size, handle, ret) (0)
-- 
1.7.2
