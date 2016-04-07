From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  7 Apr 2016 18:42:04 +0100
Subject: [PATCH 1/5] iommu: remove unused priv field from struct iommu_ops
In-Reply-To: <cover.1460048991.git.robin.murphy@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
Message-ID: <8ff9d80f39489b283f168afbf92971631788ae0c.1460048991.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

The priv field from iommu_ops is a hangover from the of_dma_configure
series and isn't actually used. Remove it before it has chance to
spread.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/linux/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 62a5eae..45b055d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -157,7 +157,6 @@ struct iommu_dm_region {
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of supported page sizes
- * @priv: per-instance data private to the iommu driver
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -199,7 +198,6 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 
 	unsigned long pgsize_bitmap;
-	void *priv;
 };
 
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
-- 
2.7.3.dirty
