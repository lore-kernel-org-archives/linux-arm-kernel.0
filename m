From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:13 +0300
Subject: [PATCH 10/23] iommu/tegra: smmu: Move IOMMU to core_initcall
Message-ID: <1372238906-9346-11-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move IOMMU to core_initcall in order to instanciate this device earlier
than others since IOMMU driver needs to reigster other platform
devices as IOMMU'able.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index f6f120e..4c16c90 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1288,7 +1288,7 @@ static void __exit tegra_smmu_exit(void)
 	platform_driver_unregister(&tegra_smmu_driver);
 }
 
-subsys_initcall(tegra_smmu_init);
+core_initcall(tegra_smmu_init);
 module_exit(tegra_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
-- 
1.8.1.5
