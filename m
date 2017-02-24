From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 24 Feb 2017 14:59:27 +0100
Subject: [PATCH v4 1/2] arm64: dts: r8a7795: Add Cortex-A53 CPU cores
In-Reply-To: <1487944768-31983-1-git-send-email-geert+renesas@glider.be>
References: <1487944768-31983-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1487944768-31983-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Cortex-A53 CPU cores to r8a7795 SoC for a total of 8
cores (4 x Cortex-A57 + 4 x Cortex-A53).

Based on work by Takeshi Kihara and Dirk Behme.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Drop bogus links from the pmu_a57 node to the CA53 nodes,

v3:
  - Link CPU nodes 100-103 to their L2 cache nodes,

v2:
  - Rebased.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 46 ++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8c43e9d7a6d2f799..d8e70d75781acaa0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -73,6 +73,42 @@
 			enable-method = "psci";
 		};
 
+		a53_0: cpu at 100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_1: cpu at 101 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x101>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_2: cpu at 102 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x102>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_3: cpu at 103 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x103>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
 		L2_CA57: cache-controller at 0 {
 			compatible = "cache";
 			reg = <0>;
@@ -166,7 +202,7 @@
 			      <0x0 0xf1040000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -317,13 +353,13 @@
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
 		cpg: clock-controller at e6150000 {
-- 
2.7.4
