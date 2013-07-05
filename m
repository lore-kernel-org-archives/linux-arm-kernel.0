From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:50 +0300
Subject: [PATCH v2 15/22] iommu/tegra: smmu: Calculate ASID register offset by
 ID
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-16-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calculate ASID register offset by ID so that we can get rid of SoC
specific MACROs. This is needed for the unified SMMU driver over Tegra
SoCs.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 35f4a16..95c6c80 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -256,7 +256,7 @@ static const u32 smmu_hwgrp_asid_reg[] = {
 	HWGRP_INIT(VDE),
 	HWGRP_INIT(VI),
 };
-#define HWGRP_ASID_REG(x) (smmu_hwgrp_asid_reg[x])
+#define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)
 
 /*
  * Per client for address space
-- 
1.7.9.5
