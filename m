From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 17 Oct 2016 13:05:30 +0100
Subject: [PATCH 2/2] arm64: Wire up iommu_dma_{map, unmap}_resource()
In-Reply-To: <b6c78e6c18d98069b0fdfa219da51d2aed129aed.1476705500.git.robin.murphy@arm.com>
References: <b6c78e6c18d98069b0fdfa219da51d2aed129aed.1476705500.git.robin.murphy@arm.com>
Message-ID: <c4a521da199558b84f42d99874f93abc2cf05bb6.1476705500.git.robin.murphy@arm.com>
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
