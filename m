From: sricharan@codeaurora.org (Sricharan R)
Date: Tue,  4 Oct 2016 22:33:50 +0530
Subject: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
In-Reply-To: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1475600632-21289-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_ops for the device is not getting set to NULL in
arch_tear_down_dma_ops and this causes an issue when the
device's probe gets deferred and retried. So reset the
dma_ops to NULL.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index dde6514..b9191f0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2295,6 +2295,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 
 	__arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
+	set_dma_ops(dev, NULL);
 }
 
 #else
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
