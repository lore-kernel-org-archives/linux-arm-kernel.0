From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 21 Aug 2013 11:34:20 +0300
Subject: [patch 2/2] iommu/arm-smmu: fix iommu_present() test in init
Message-ID: <20130821083420.GG5240@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The extra semi-colon on the end breaks the test.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I can't compile this or test it.  The original code didn't work as
intended but it would still be good to test this because it changes the
code a lot.

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7243af3..913bd15 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1967,10 +1967,10 @@ static int __init arm_smmu_init(void)
 		return ret;
 
 	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type));
+	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
 
-	if (!iommu_present(&amba_bustype));
+	if (!iommu_present(&amba_bustype))
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 
 	return 0;
