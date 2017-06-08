From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:26:05 +0200
Subject: [PATCH 40/44] tile: remove dma_supported and mapping_error methods
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170608132609.32662-41-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These just duplicate the default behavior if no method is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/tile/kernel/pci-dma.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index 569bb6dd154a..f2abedc8a080 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -317,18 +317,6 @@ static void tile_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-static inline int
-tile_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int
-tile_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static const struct dma_map_ops tile_default_dma_map_ops = {
 	.alloc = tile_dma_alloc_coherent,
 	.free = tile_dma_free_coherent,
@@ -340,8 +328,6 @@ static const struct dma_map_ops tile_default_dma_map_ops = {
 	.sync_single_for_device = tile_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_dma_sync_sg_for_device,
-	.mapping_error = tile_dma_mapping_error,
-	.dma_supported = tile_dma_supported
 };
 
 const struct dma_map_ops *tile_dma_map_ops = &tile_default_dma_map_ops;
@@ -504,18 +490,6 @@ static void tile_pci_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-static inline int
-tile_pci_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int
-tile_pci_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static const struct dma_map_ops tile_pci_default_dma_map_ops = {
 	.alloc = tile_pci_dma_alloc_coherent,
 	.free = tile_pci_dma_free_coherent,
@@ -527,8 +501,6 @@ static const struct dma_map_ops tile_pci_default_dma_map_ops = {
 	.sync_single_for_device = tile_pci_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_pci_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
-	.mapping_error = tile_pci_dma_mapping_error,
-	.dma_supported = tile_pci_dma_supported
 };
 
 const struct dma_map_ops *gx_pci_dma_map_ops = &tile_pci_default_dma_map_ops;
@@ -578,8 +550,6 @@ static const struct dma_map_ops pci_hybrid_dma_ops = {
 	.sync_single_for_device = tile_pci_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_pci_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
-	.mapping_error = tile_pci_dma_mapping_error,
-	.dma_supported = tile_pci_dma_supported
 };
 
 const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &pci_swiotlb_dma_ops;
-- 
2.11.0
