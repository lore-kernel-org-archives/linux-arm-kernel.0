From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Mon, 13 Oct 2014 15:06:18 +0200
Subject: [PATCH 3/3] iommu/arm-smmu: add IOMMU_CAP_NOEXEC to the ARM SMMU
 driver
In-Reply-To: <1413205579-6124-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1413205579-6124-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <1413205579-6124-4-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMMU supports the IOMMU_NOEXEC protection flag. Add the
corresponding IOMMU capability.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/iommu/arm-smmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 566c176..c8fc02f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1569,6 +1569,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
 		return true; /* MSIs are just memory writes */
+	case IOMMU_CAP_NOEXEC:
+		return true;
 	default:
 		return false;
 	}
-- 
2.1.1
