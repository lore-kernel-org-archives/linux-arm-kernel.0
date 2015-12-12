From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 12 Dec 2015 08:16:46 +0100
Subject: [PATCH 1/2] arm64: dts: r8a7795: Add Cortex-A53 CPU cores
Message-ID: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Cortex-A53 CPU cores to r8a7795 SoC for a total of 8
cores (4 x Cortex-A57 + 4 x Cortex-A53).

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Note: This patch is picked from

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/log/?h=v4.2/rcar-3.0.x

and rebased against

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/log/?h=next renesas-next-20151211v2-v4.4-rc1

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 46 +++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b9229a4..3633a2a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -60,6 +60,30 @@
 			device_type = "cpu";
 			enable-method = "psci";
 		};
+		a53_0: cpu at 100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+		a53_1: cpu at 101 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+		a53_2: cpu at 102 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x102>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+		a53_3: cpu at 103 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x103>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
 	};
 
 	extal_clk: extal {
@@ -115,7 +139,7 @@
 			reg = <0x0 0xf1010000 0 0x1000>,
 			      <0x0 0xf1020000 0 0x2000>;
 			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		gpio0: gpio at e6050000 {
@@ -235,23 +259,31 @@
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-affinity = <&a57_0>,
 					     <&a57_1>,
 					     <&a57_2>,
-					     <&a57_3>;
+					     <&a57_3>,
+					     <&a53_0>,
+					     <&a53_1>,
+					     <&a53_2>,
+					     <&a53_3>;
 		};
 
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
2.6.4
