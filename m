From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:18 +0200
Subject: [PATCH 06/38] ARM: dts: r8a7743: Add GPIO support
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <16ffb25335d7e91cebae9c29252536ddbeac96fa.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Describe GPIO blocks in the R8A7743 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 120 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 8d6b14075865..838085946588 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -65,6 +65,126 @@
 			resets = <&cpg 408>;
 		};
 
+		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
+		};
+
+		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
+		};
+
+		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
+		};
+
+		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
+		};
+
+		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
+		};
+
+		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
+		};
+
+		gpio6: gpio at e6055400 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 192 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 905>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
+		};
+
+		gpio7: gpio at e6055800 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055800 0 0x50>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 224 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 904>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 904>;
+		};
+
 		irqc: interrupt-controller at e61c0000 {
 			compatible = "renesas,irqc-r8a7743", "renesas,irqc";
 			#interrupt-cells = <2>;
-- 
2.1.4
