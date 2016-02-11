From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Feb 2016 14:34:21 +0000
Subject: [RFC v2 14/15] iommu/arm-smmu: do not advertise IOMMU_CAP_INTR_REMAP
In-Reply-To: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
References: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1455201262-5259-15-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not advertise IOMMU_CAP_INTR_REMAP for arm-smmu. Indeed the
irq_remapping capability is abstracted on irqchip side for ARM as
opposed to Intel IOMMU featuring IRQ remapping HW.

So to check IRQ remmapping capability, the msi domain needs to be
checked instead.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ae8a97d..9a83285 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1354,7 +1354,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		 */
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
+		return false; /* MSIs are just memory writes */
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
-- 
1.9.1
