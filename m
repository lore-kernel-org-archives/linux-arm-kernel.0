From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:02 +0200
Subject: [PATCH 100/102] arm64: dts: renesas: r8a77970: add VIN and CSI-2 nodes
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <51b09327863d7a97e5e284262daf44c9aa60827e.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 152 ++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index c8464d1ef1b2..98a2317a16c4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -547,6 +547,119 @@
 			status = "disabled";
 		};
 
+
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a77970";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			renesas,id = <0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin0csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin0>;
+					};
+				};
+			};
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a77970";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
+			renesas,id = <1>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin1csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin1>;
+					};
+				};
+			};
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a77970";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 809>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 809>;
+			renesas,id = <2>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin2csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin2>;
+					};
+				};
+			};
+		};
+
+		vin3: video at e6ef3000 {
+			compatible = "renesas,vin-r8a77970";
+			reg = <0 0xe6ef3000 0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 808>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 808>;
+			renesas,id = <3>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin3csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin3>;
+					};
+				};
+			};
+		};
+
 		dmac1: dma-controller at e7300000 {
 			compatible = "renesas,dmac-r8a77970",
 				     "renesas,rcar-dmac";
@@ -679,6 +792,45 @@
 			resets = <&cpg 603>;
 		};
 
+		csi40: csi2 at feaa0000 {
+			compatible = "renesas,r8a77970-csi2";
+			reg = <0 0xfeaa0000 0 0x10000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi40vin0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&vin0csi40>;
+					};
+					csi40vin1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&vin1csi40>;
+					};
+					csi40vin2: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&vin2csi40>;
+					};
+					csi40vin3: endpoint at 3 {
+						reg = <3>;
+						remote-endpoint = <&vin3csi40>;
+					};
+				};
+			};
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a77970";
 			reg = <0 0xfeb00000 0 0x80000>;
-- 
2.11.0
