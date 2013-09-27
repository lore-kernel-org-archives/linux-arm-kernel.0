From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 12:02:11 +0200
Subject: [PATCH] iommu/arm-smmu: Switch to subsys_initcall for driver
 registration
In-Reply-To: <20130927092425.GG3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-2-git-send-email-andreas.herrmann@calxeda.com>
 <20130927085811.GD8319@mudshark.cambridge.arm.com>
 <20130927092425.GG3315@alberich>
Message-ID: <20130927100211.GK3315@alberich>
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
