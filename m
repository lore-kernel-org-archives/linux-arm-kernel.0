From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Tue, 23 Sep 2014 16:46:02 +0200
Subject: [PATCHv7 03/26] iommu/arm-smmu: add IOMMU_CAP_NOEXEC to the ARM SMMU
 driver
In-Reply-To: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <1411483586-29304-4-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMMU supports the IOMMU_NOEXEC protection flag. Add the
corresponding IOMMU capability.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/iommu/arm-smmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c7cbdda..7c0fa25 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1539,6 +1539,8 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 		return features & ARM_SMMU_FEAT_COHERENT_WALK;
 	case IOMMU_CAP_INTR_REMAP:
 		return 1; /* MSIs are just memory writes */
+	case IOMMU_CAP_NOEXEC:
+		return 1;
 	default:
 		return 0;
 	}
-- 
1.8.3.2
