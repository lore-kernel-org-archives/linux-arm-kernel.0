From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:47 +0100
Subject: [PATCH 21/40] arm64: dts: renesas: r8a779{7|8}0: add TMU support
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <cb202e7c5895437fbabd0e575cf2530c65763dde.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe TMUs in the R8A779{7|8}0 device trees.

Based on the original (and large) patches by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 65 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 65 +++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 4abd154bca1f..563428d1cdc2 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -329,6 +329,71 @@
 			resets = <&cpg 407>;
 		};
 
+		tmu0: timer at e61e0000 {
+			compatible = "renesas,tmu-r8a77970", "renesas,tmu";
+			reg = <0 0xe61e0000 0 0x30>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 125>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 125>;
+			status = "disabled";
+		};
+
+		tmu1: timer at e6fc0000 {
+			compatible = "renesas,tmu-r8a77970", "renesas,tmu";
+			reg = <0 0xe6fc0000 0 0x30>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
+			status = "disabled";
+		};
+
+		tmu2: timer at e6fd0000 {
+			compatible = "renesas,tmu-r8a77970", "renesas,tmu";
+			reg = <0 0xe6fd0000 0 0x30>;
+			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 123>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 123>;
+			status = "disabled";
+		};
+
+		tmu3: timer at e6fe0000 {
+			compatible = "renesas,tmu-r8a77970", "renesas,tmu";
+			reg = <0 0xe6fe0000 0 0x30>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 122>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 122>;
+			status = "disabled";
+		};
+
+		tmu4: timer at ffc00000 {
+			compatible = "renesas,tmu-r8a77970", "renesas,tmu";
+			reg = <0 0xffc00000 0 0x30>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 121>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 121>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at e6500000 {
 			compatible = "renesas,i2c-r8a77970",
 				     "renesas,rcar-gen3-i2c";
diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index ce2c9955df75..5bd9b2547c36 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -359,6 +359,71 @@
 			resets = <&cpg 407>;
 		};
 
+		tmu0: timer at e61e0000 {
+			compatible = "renesas,tmu-r8a77980", "renesas,tmu";
+			reg = <0 0xe61e0000 0 0x30>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 125>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 125>;
+			status = "disabled";
+		};
+
+		tmu1: timer at e6fc0000 {
+			compatible = "renesas,tmu-r8a77980", "renesas,tmu";
+			reg = <0 0xe6fc0000 0 0x30>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
+			status = "disabled";
+		};
+
+		tmu2: timer at e6fd0000 {
+			compatible = "renesas,tmu-r8a77980", "renesas,tmu";
+			reg = <0 0xe6fd0000 0 0x30>;
+			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 123>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 123>;
+			status = "disabled";
+		};
+
+		tmu3: timer at e6fe0000 {
+			compatible = "renesas,tmu-r8a77980", "renesas,tmu";
+			reg = <0 0xe6fe0000 0 0x30>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 122>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 122>;
+			status = "disabled";
+		};
+
+		tmu4: timer at ffc00000 {
+			compatible = "renesas,tmu-r8a77980", "renesas,tmu";
+			reg = <0 0xffc00000 0 0x30>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 121>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 121>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at e6500000 {
 			compatible = "renesas,i2c-r8a77980",
 				     "renesas,rcar-gen3-i2c";
-- 
2.11.0
