From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:50:05 +0100
Subject: [PATCH 7/7] iommu/arm-smmu: support MMU-401
In-Reply-To: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409849405-17347-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <Robin.Murphy@arm.com>

MMU-401 is similar to MMU-400, but updated with limited ARMv8 support.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
 drivers/iommu/arm-smmu.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 2d0f7cd867ea..06760503a819 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -14,6 +14,7 @@ conditions.
                         "arm,smmu-v1"
                         "arm,smmu-v2"
                         "arm,mmu-400"
+                        "arm,mmu-401"
                         "arm,mmu-500"
 
                   depending on the particular implementation and/or the
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1f447e7843ed..d2d8cdaf4f0b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1882,6 +1882,7 @@ static struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = (void *)ARM_SMMU_V1 },
 	{ .compatible = "arm,smmu-v2", .data = (void *)ARM_SMMU_V2 },
 	{ .compatible = "arm,mmu-400", .data = (void *)ARM_SMMU_V1 },
+	{ .compatible = "arm,mmu-401", .data = (void *)ARM_SMMU_V1 },
 	{ .compatible = "arm,mmu-500", .data = (void *)ARM_SMMU_V2 },
 	{ },
 };
-- 
2.1.0
