From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 26 Oct 2016 18:43:57 +0100
Subject: [PATCH v2 2/2] arm64: Wire up iommu_dma_{map, unmap}_resource()
In-Reply-To: <4e84146ae49a4edd5f1226d76617be9aa92a58ee.1477503578.git.robin.murphy@arm.com>
References: <4e84146ae49a4edd5f1226d76617be9aa92a58ee.1477503578.git.robin.murphy@arm.com>
Message-ID: <44f25ba8a19dcd39479292c3a2da4b5c996e161e.1477503578.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With no coherency to worry about, just plug'em straight in.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3f74d0d98de6..5cd0a383b14b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -796,6 +796,8 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	.sync_single_for_device = __iommu_sync_single_for_device,
 	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
 	.sync_sg_for_device = __iommu_sync_sg_for_device,
+	.map_resource = iommu_dma_map_resource,
+	.unmap_resource = iommu_dma_unmap_resource,
 	.dma_supported = iommu_dma_supported,
 	.mapping_error = iommu_dma_mapping_error,
 };
-- 
1.9.1
