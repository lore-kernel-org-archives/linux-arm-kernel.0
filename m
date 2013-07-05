From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:46 +0300
Subject: [PATCH v2 11/22] iommu/tegra: smmu: Add Tegra 114 support
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-12-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra 114 SMMU uses the almost same logic as one in Tegra 30 except
that they have different HaredWare Accelerators(HWA). Those difference
is provided from DT.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         |    2 +-
 drivers/iommu/tegra-smmu.c                         |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 89fb543..ce5c43e 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -1,7 +1,7 @@
 NVIDIA Tegra 30 IOMMU H/W, SMMU (System Memory Management Unit)
 
 Required properties:
-- compatible : "nvidia,tegra30-smmu"
+- compatible : "nvidia,tegra114-smmu", "nvidia,tegra30-smmu"
 - reg : Should contain 3 register banks(address and length) for each
   of the SMMU register blocks.
 - interrupts : Should contain MC General interrupt.
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4c16c90..3e03c69 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1262,6 +1262,7 @@ const struct dev_pm_ops tegra_smmu_pm_ops = {
 };
 
 static struct of_device_id tegra_smmu_of_match[] = {
+	{ .compatible = "nvidia,tegra114-smmu", },
 	{ .compatible = "nvidia,tegra30-smmu", },
 	{ },
 };
-- 
1.7.9.5
