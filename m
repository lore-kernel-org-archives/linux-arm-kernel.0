From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri,  2 Sep 2011 20:32:31 +0300
Subject: [PATCH 2/7] iommu/omap: cleanup: remove a redundant statement
In-Reply-To: <1314984756-4400-1-git-send-email-ohad@wizery.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
Message-ID: <1314984756-4400-3-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tiny cleanup that removes a redundant 'return' statement.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/omap-iommu.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 90744af..4311bc3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1069,12 +1069,10 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 	iotlb_init_entry(&e, da, pa, flags);
 
 	ret = omap_iopgtable_store_entry(oiommu, &e);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "omap_iopgtable_store_entry failed: %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
-- 
1.7.4.1
