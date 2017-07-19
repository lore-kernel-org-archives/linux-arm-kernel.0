From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 19 Jul 2017 15:03:56 +0530
Subject: [PATCH 3/5] iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM SMMUv3
 driver
In-Reply-To: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1500456838-18405-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMMUv3 support bypassing transactions for which domain
is not configured. The patch adds corresponding IOMMU capability
to advertise this fact.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 568c400..a6c7f66 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1423,6 +1423,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_NOEXEC:
 		return true;
+	case IOMMU_CAP_BYPASS:
+		return true;
 	default:
 		return false;
 	}
-- 
2.7.4
