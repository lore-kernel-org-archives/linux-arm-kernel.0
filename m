From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:05 +0300
Subject: [PATCH 02/23] ARM: dt: tegra30: iommu: Add "nvidia,swgroups"
Message-ID: <1372238906-9346-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a bitmap that indicates which HardWare Accelerators(HWA) are
supported on Tegra30 SoC.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt | 6 +++++-
 arch/arm/boot/dts/tegra30.dtsi                                  | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 89fb543..6be51f6 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -8,14 +8,18 @@ Required properties:
 - nvidia,#asids : # of ASIDs
 - dma-window : IOVA start address and length.
 - nvidia,ahb : phandle to the ahb bus connected to SMMU.
+- nvidia,swgroups: A bit map of supported HardWare Accelerators(HWA).
+  Each bit represents one sgroup. The assignments may be found in header
+  file <dt-bindings/iommu/tegra-swgid.h>.
 
 Example:
-	smmu {
+	iommu {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
 		       0x7000f228 0x05c>;
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
 	};
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d8783f0..14ec3f9 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -461,6 +461,7 @@
 		       0x7000f228 0x05c>;
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
 	};
 
-- 
1.8.1.5
