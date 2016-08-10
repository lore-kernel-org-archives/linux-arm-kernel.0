From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Wed, 10 Aug 2016 13:22:14 +0200
Subject: [PATCHv9 1/6] dma-mapping: add {map,unmap}_resource to dma_map_ops
In-Reply-To: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160810112219.17964-2-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add methods to handle mapping of device resources from a physical
address. This is needed for example to be able to map MMIO FIFO
registers to a IOMMU.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/linux/dma-mapping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c44f8ee..e3bd27f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -95,6 +95,12 @@ struct dma_map_ops {
 			 struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir,
 			 unsigned long attrs);
+	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_addr,
+			       size_t size, enum dma_data_direction dir,
+			       unsigned long attrs);
+	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
+			   size_t size, enum dma_data_direction dir,
+			   unsigned long attrs);
 	void (*sync_single_for_cpu)(struct device *dev,
 				    dma_addr_t dma_handle, size_t size,
 				    enum dma_data_direction dir);
-- 
2.9.2
