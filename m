From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jan 2018 22:42:36 +0300
Subject: [PATCH 3/5] arm64: dts: renesas: r8a77970: add DU support
Message-ID: <20180119195435.812317522@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A77970 part of the DU device node.

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -630,6 +630,34 @@
 			resets = <&cpg 623>;
 			renesas,fcp = <&fcpvd0>;
 		};
+
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a77970";
+			reg = <0 0xfeb00000 0 0x80000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>;
+			clock-names = "du.0";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			vsps = <&vspd0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					du_out_lvds: endpoint {
+					};
+				};
+			};
+		};
 	};
 
 	timer {
