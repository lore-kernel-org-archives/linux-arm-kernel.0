From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue,  1 Oct 2013 14:39:05 +0200
Subject: [PATCH 1/6] iommu/arm-smmu: Switch to subsys_initcall for driver
 registration
In-Reply-To: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380631150-10783-2-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should ensure that arm-smmu is initialized before other drivers
start handling devices that propably need smmu support.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 181c9ba..548f5d1 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1981,7 +1981,7 @@ static void __exit arm_smmu_exit(void)
 	return platform_driver_unregister(&arm_smmu_driver);
 }
 
-module_init(arm_smmu_init);
+subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
-- 
1.7.9.5
