From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  7 Mar 2017 19:03:22 +0100
Subject: [PATCH v2 1/5] arm64: dts: r8a7796: Add Cortex-A57 CPU cores
In-Reply-To: <1488909806-3322-1-git-send-email-geert+renesas@glider.be>
References: <1488909806-3322-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1488909806-3322-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Cortex-A57 CPU cores to R8A7796 SoC for a total of
2 x Cortex-A57.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Rebased]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 27f7dd9bd988d3b0..d2a2110fc7fc3d23 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -37,7 +37,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		/* 1 core only at this point */
 		a57_0: cpu at 0 {
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
@@ -47,6 +46,15 @@
 			enable-method = "psci";
 		};
 
+		a57_1: cpu at 1 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x1>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7796_PD_CA57_CPU1>;
+			next-level-cache = <&L2_CA57>;
+			enable-method = "psci";
+		};
+
 		L2_CA57: cache-controller-0 {
 			compatible = "cache";
 			power-domains = <&sysc R8A7796_PD_CA57_SCU>;
@@ -100,7 +108,7 @@
 			      <0x0 0xf1040000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
@@ -109,13 +117,13 @@
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
 		wdt0: watchdog at e6020000 {
-- 
2.7.4
