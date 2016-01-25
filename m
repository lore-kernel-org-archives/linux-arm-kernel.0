From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 25 Jan 2016 15:14:09 +0000
Subject: [PATCH v2 2/2] arm64: dts: Add support for Juno r2 board
In-Reply-To: <1453734849-13790-1-git-send-email-sudeep.holla@arm.com>
References: <1453734849-13790-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1453734849-13790-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juno r2 is identical to Juno r1 with Cortex A57 cores replaced by
Cortex A72 cores.

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/arm-boards   |  1 +
 arch/arm64/boot/dts/arm/Makefile                   |  2 +-
 .../boot/dts/arm/{juno-r1.dts => juno-r2.dts}      | 30 +++++++++++-----------
 3 files changed, 17 insertions(+), 16 deletions(-)
 copy arch/arm64/boot/dts/arm/{juno-r1.dts => juno-r2.dts} (87%)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 1a709970e7f7..70601a58c433 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -180,6 +180,7 @@ described under the RS1 memory mapping.
 Required properties (in root node):
 	compatible = "arm,juno";	/* For Juno r0 board */
 	compatible = "arm,juno-r1";	/* For Juno r1 board */
+	compatible = "arm,juno-r2";	/* For Juno r2 board */
 
 Required nodes:
 The description for the board must include:
diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index bb3c07209676..c0bf56b9ce3d 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -1,5 +1,5 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb
-dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
 
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
similarity index 87%
copy from arch/arm64/boot/dts/arm/juno-r1.dts
copy to arch/arm64/boot/dts/arm/juno-r2.dts
index d95d9e7e2dc0..88ecd6182b67 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -11,8 +11,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
-	model = "ARM Juno development board (r1)";
-	compatible = "arm,juno-r1", "arm,juno", "arm,vexpress";
+	model = "ARM Juno development board (r2)";
+	compatible = "arm,juno-r2", "arm,juno", "arm,vexpress";
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -37,10 +37,10 @@
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&A57_0>;
+					cpu = <&A72_0>;
 				};
 				core1 {
-					cpu = <&A57_1>;
+					cpu = <&A72_1>;
 				};
 			};
 
@@ -82,22 +82,22 @@
 			};
 		};
 
-		A57_0: cpu at 0 {
-			compatible = "arm,cortex-a57","arm,armv8";
+		A72_0: cpu at 0 {
+			compatible = "arm,cortex-a72","arm,armv8";
 			reg = <0x0 0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
-			next-level-cache = <&A57_L2>;
+			next-level-cache = <&A72_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
-		A57_1: cpu at 1 {
-			compatible = "arm,cortex-a57","arm,armv8";
+		A72_1: cpu at 1 {
+			compatible = "arm,cortex-a72","arm,armv8";
 			reg = <0x0 0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
-			next-level-cache = <&A57_L2>;
+			next-level-cache = <&A72_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
@@ -142,7 +142,7 @@
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
-		A57_L2: l2-cache0 {
+		A72_L2: l2-cache0 {
 			compatible = "cache";
 		};
 
@@ -151,12 +151,12 @@
 		};
 	};
 
-	pmu_a57 {
-		compatible = "arm,cortex-a57-pmu";
+	pmu_a72 {
+		compatible = "arm,cortex-a72-pmu";
 		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&A57_0>,
-				     <&A57_1>;
+		interrupt-affinity = <&A72_0>,
+				     <&A72_1>;
 	};
 
 	pmu_a53 {
-- 
1.9.1
