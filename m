From: john.garry@huawei.com (John Garry)
Date: Fri, 17 Aug 2018 23:42:22 +0800
Subject: [PATCH] iommu/arm-smmu-v3: Fix a couple of minor comment typos
Message-ID: <1534520542-92851-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some comment typos spotted.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5059d09..feef122 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -708,7 +708,7 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
 }
 
 /*
- * Wait for the SMMU to consume items. If drain is true, wait until the queue
+ * Wait for the SMMU to consume items. If sync is true, wait until the queue
  * is empty. Otherwise, wait until there is at least one free slot.
  */
 static int queue_poll_cons(struct arm_smmu_queue *q, bool sync, bool wfe)
@@ -2353,8 +2353,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->combined_irq;
 	if (irq) {
 		/*
-		 * Cavium ThunderX2 implementation doesn't not support unique
-		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
+		 * Cavium ThunderX2 implementation doesn't support unique irq
+		 * lines. Use a single irq line for all the SMMUv3 interrupts.
 		 */
 		ret = devm_request_threaded_irq(smmu->dev, irq,
 					arm_smmu_combined_irq_handler,
-- 
1.9.1
