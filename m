From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:18 +0300
Subject: [PATCH 15/23] iommu/tegra: smmu: Calculate ASID register offset by ID
Message-ID: <1372238906-9346-16-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calculate ASID register offset by ID so that we can get rid of SoC
specific MACROs. This is needed for the unified SMMU driver over Tegra
SoCs.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
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
1.8.1.5
