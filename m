From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 12:14:35 +0000
Subject: [PATCH 3/3] iommu/arm-smmu: fix error return code in
 arm_smmu_device_dt_probe()
In-Reply-To: <1385727275-19082-1-git-send-email-will.deacon@arm.com>
References: <1385727275-19082-1-git-send-email-will.deacon@arm.com>
Message-ID: <1385727275-19082-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENODEV instead of 0 when context interrupt number
does no match in arm_smmu_device_dt_probe().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ef77e3dd6dd2..e46a88700b68 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1852,6 +1852,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		dev_err(dev,
 			"found only %d context interrupt(s) but %d required\n",
 			smmu->num_context_irqs, smmu->num_context_banks);
+		err = -ENODEV;
 		goto out_put_parent;
 	}
 
-- 
1.8.2.2
