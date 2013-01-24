From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 24 Jan 2013 15:16:56 +0200
Subject: [PATCH 1/2] ARM: dma-mapping: Add macro to_dma_iommu_mapping()
Message-ID: <1359033425-6674-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be built without CONFIG_ARM_DMA_USE_IOMMU.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/include/asm/device.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 5191a83..6fbe514 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -33,4 +33,10 @@ struct pdev_archdata {
 #endif
 };
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+#define to_dma_iommu_mapping(dev) ((dev)->archdata.mapping)
+#else
+#define to_dma_iommu_mapping(dev) NULL
+#endif
+
 #endif
-- 
1.7.9.5
