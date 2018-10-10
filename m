From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Wed, 10 Oct 2018 17:44:07 +0300
Subject: [PATCH] iommu: arm-smmu: handle client iommu translation fault
 handlers
Message-ID: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call iommu client translation fault handler(s).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 066f4c8daf4e..02a8aab0cc59 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 			    fsr, iova, fsynr, cfg->cbndx);
 
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
+
+	report_iommu_fault(domain, smmu->dev, iova, 0);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1
