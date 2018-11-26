From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:30 +0100
Subject: [PATCH 04/40] arm64: dts: renesas: r8a779{7|8}0: add PWM support
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <de625477c632abecf23feba94ff4c5904764f57d.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe PWMs in the R8A779{7|8}0 device trees.

Based on the original (and large) patches by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 50 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 50 +++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index cba7885cf7c3..e58040e76303 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -543,6 +543,56 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a77970", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a77970", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a77970", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a77970", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a77970",
 				     "renesas,rcar-gen3-scif",
diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index d4952b527d14..a1fda9901423 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -594,6 +594,56 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a77980", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a77980", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a77980", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a77980", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a77980", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a77980",
 				     "renesas,rcar-gen3-scif",
-- 
2.11.0
