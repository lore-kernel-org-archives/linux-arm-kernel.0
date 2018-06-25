From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:17 +0200
Subject: [PATCH 22/29] arm64: dts: renesas: r8a77980: add GPIO support
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <efcb52e35d162dc9104be56492b65049a17dc6a4.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe all 6 GPIO controllers in the R8A77980 device tree.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 90 +++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 424d5f12cdd3..68cede26b01a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -118,6 +118,96 @@
 		#size-cells = <2>;
 		ranges;
 
+		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a77980",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 22>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
+		};
+
+		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a77980",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 28>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
+		};
+
+		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a77980",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 30>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
+		};
+
+		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a77980",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 17>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
+		};
+
+		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a77980",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 25>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
+		};
+
+		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a77980",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 15>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
+		};
+
 		pfc: pin-controller at e6060000 {
 			compatible = "renesas,pfc-r8a77980";
 			reg = <0 0xe6060000 0 0x50c>;
-- 
2.11.0
