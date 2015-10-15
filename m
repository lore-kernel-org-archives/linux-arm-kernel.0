From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Oct 2015 16:04:20 +0100
Subject: [PATCH 2/6] iommu/arm-smmu: Remove unneeded '0x' annotation
In-Reply-To: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
References: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
Message-ID: <1444921464-14895-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

'%pad' automatically prints with '0x', so remove the explicit '0x'
annotation.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 48a39dfa9777..677fba9e6b11 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1222,7 +1222,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
 				      !(tmp & ATSR_ACTIVE), 5, 50)) {
 		dev_err(dev,
-			"iova to phys timed out on 0x%pad. Falling back to software table walk.\n",
+			"iova to phys timed out on %pad. Falling back to software table walk.\n",
 			&iova);
 		return ops->iova_to_phys(ops, iova);
 	}
-- 
2.1.4
