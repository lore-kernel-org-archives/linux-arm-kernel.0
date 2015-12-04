From: dirk.behme@gmail.com (Dirk Behme)
Date: Fri,  4 Dec 2015 14:38:52 +0100
Subject: [PATCH 2/3] arm64: dts: r8a7795: Add Cortex-A57 CPU cores
In-Reply-To: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <1449236333-4410-2-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Add Cortex-A57 CPU cores to r8a7795 SoC for a total of 4 x Cortex-A57.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
---

Note: This patch picked from

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/log/?h=v4.2/rcar-3.0.x

and rebased against

https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/gen3-latest renesas-drivers-2015-12-01-v4.4-rc3

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 5611597..946a5bb 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -35,13 +35,31 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		/* 1 core only at this point */
 		a57_0: cpu at 0 {
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
 		};
+
+		a57_1: cpu at 1 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x1>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+		a57_2: cpu at 2 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x2>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+		a57_3: cpu at 3 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x3>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
 	};
 
 	extal_clk: extal {
@@ -101,6 +119,7 @@
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
+
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -113,7 +132,7 @@
 			reg = <0x0 0xf1010000 0 0x1000>,
 			      <0x0 0xf1020000 0 0x2000>;
 			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		gpio0: gpio at e6050000 {
@@ -231,13 +250,13 @@
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
 		cpg: clock-controller at e6150000 {
-- 
2.6.3
