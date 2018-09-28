From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:20:20 +0200
Subject: [PATCH 09/14] arm64: dts: renesas: r8a779{7|8}0: add TPU support
In-Reply-To: <cover.1538125184.git.horms+renesas@verge.net.au>
References: <cover.1538125184.git.horms+renesas@verge.net.au>
Message-ID: <dd809b7de27cff710658febdde65304ec1a3ea82.1538125184.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe TPU in the R8A779{7|8}0 device trees.

Based on the original (and large) patches by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 934a15f9171f..cba7885cf7c3 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -614,6 +614,16 @@
 			status = "disabled";
 		};
 
+		tpu: pwm at e6e80000 {
+			compatible = "renesas,tpu-r8a77970", "renesas,tpu";
+			reg = <0 0xe6e80000 0 0x148>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 304>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 304>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
 
 		vin0: video at e6ef0000 {
 			compatible = "renesas,vin-r8a77970";
diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index ba1d281deb07..d4952b527d14 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -666,6 +666,17 @@
 			status = "disabled";
 		};
 
+		tpu: pwm at e6e80000 {
+			compatible = "renesas,tpu-r8a77980", "renesas,tpu";
+			reg = <0 0xe6e80000 0 0x148>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 304>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 304>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		vin0: video at e6ef0000 {
 			compatible = "renesas,vin-r8a77980";
 			reg = <0 0xe6ef0000 0 0x1000>;
-- 
2.11.0
