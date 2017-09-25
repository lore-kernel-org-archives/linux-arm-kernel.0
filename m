From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 25 Sep 2017 14:55:40 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Correct COHACC override message
Message-ID: <d41c3eb397c0f406c75b1e52c85c45ef87dc325d.1506347740.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Slightly confusingly, when reporting a mismatch of the ID register
value, we still refer to the IORT COHACC override flag as the
"dma-coherent property" if we booted with ACPI. Update the message
to be firmware-agnostic in line with SMMUv2.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 47f52b1ab838..4c63b3cf4eba 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2523,7 +2523,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	 * register, but warn on mismatch.
 	 */
 	if (!!(reg & IDR0_COHACC) != coherent)
-		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
+		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
 			 coherent ? "true" : "false");
 
 	switch (reg & IDR0_STALL_MODEL_MASK << IDR0_STALL_MODEL_SHIFT) {
-- 
2.13.4.dirty
