From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:02:57 +0200
Subject: [PATCH 02/29] arm64: dts: renesas: r8a77995: Add IPMMU power domains
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <7e26bd3334bb21daefe092dc34e7a8e38bac576f.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add power domain information to the R-Car D3 IPMMU device nodes.
As specified by the data sheet, all the IPMMU devices are always on.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 2506f46293e8..44268671c487 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -408,6 +408,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xe6740000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -415,6 +416,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xe7740000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -422,6 +424,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xe6570000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -430,6 +433,7 @@
 			reg = <0 0xe67b0000 0 0x1000>;
 			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -437,6 +441,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xec670000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -444,6 +449,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xfd800000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -451,6 +457,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xffc80000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 10>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -458,6 +465,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xfe6b0000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -465,6 +473,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xfebd0000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -472,6 +481,7 @@
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xfe990000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 16>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
-- 
2.11.0
