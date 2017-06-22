From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 22 Jun 2017 12:51:00 +0530
Subject: [PATCH] iommu: arm-smmu-v3: make of_device_ids const
Message-ID: <52ec478cd35247ef219b448b174bcfcae87da005.1498115942.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..7d3f08a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2768,7 +2768,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id arm_smmu_of_match[] = {
+static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
 };
-- 
1.9.1
