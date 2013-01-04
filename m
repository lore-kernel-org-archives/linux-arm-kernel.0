From: prathyush.k@samsung.com (Prathyush K)
Date: Fri, 04 Jan 2013 06:22:42 -0500
Subject: [PATCH v2] arm: dma mapping: export arm iommu functions
Message-ID: <1357298562-28110-1-git-send-email-prathyush.k@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EXPORT_SYMBOL_GPL calls to the three arm iommu
functions - arm_iommu_create_mapping, arm_iommu_free_mapping
and arm_iommu_attach_device. These three functions are arm specific
wrapper functions for creating/freeing/using an iommu mapping and
they are called by various drivers. If any of these drivers need
to be built as dynamic modules, these functions need to be exported.

Changelog v2: using EXPORT_SYMBOL_GPL as suggested by Marek.

Signed-off-by: Prathyush K <prathyush.k@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b2fb87..226ebcf 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1797,6 +1797,7 @@ err2:
 err:
 	return ERR_PTR(err);
 }
+EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
 static void release_iommu_mapping(struct kref *kref)
 {
@@ -1813,6 +1814,7 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 	if (mapping)
 		kref_put(&mapping->kref, release_iommu_mapping);
 }
+EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
 
 /**
  * arm_iommu_attach_device
@@ -1841,5 +1843,6 @@ int arm_iommu_attach_device(struct device *dev,
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
 }
+EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
 
 #endif
-- 
1.8.0
