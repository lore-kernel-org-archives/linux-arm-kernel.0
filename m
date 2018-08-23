From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu, 23 Aug 2018 14:23:29 +0530
Subject: [PATCH] arm64: dts: Fix various entry-method properties to reflect
 documentation
Message-ID: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The idle-states binding documentation[1] mentions that the
'entry-method' property is required on 64-bit platforms and must be
set to "psci".

commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
bindings examples") attempted to fix this earlier but clearly more is
needed.

Fix the cpu-capacity.txt documentation that uses the incorrect value so
we don't get copy-paste errors like these. Clarify the language in
idle-states.txt by removing the reference to the psci bindings that
might be causing this confusion.

Finally, fix devicetrees of various boards to reflect current
documentation.

[1] Documentation/devicetree/bindings/arm/idle-states.txt (see
idle-states node)

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
 Documentation/devicetree/bindings/arm/idle-states.txt  | 4 ++--
 arch/arm64/boot/dts/arm/juno-r1.dts                    | 2 +-
 arch/arm64/boot/dts/arm/juno-r2.dts                    | 2 +-
 arch/arm64/boot/dts/arm/juno.dts                       | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi         | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi         | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi         | 2 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi              | 2 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi                   | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 7809fbe0cdb7..9b5685a1d15d 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -94,7 +94,7 @@ cpus {
 	};
 
 	idle-states {
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_SLEEP_0: cpu-sleep-0 {
 			compatible = "arm,idle-state";
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 7a591333f2b1..2c73847499ab 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -237,8 +237,8 @@ processor idle states, defined as device tree nodes, are listed.
 		Value type: <stringlist>
 		Usage and definition depend on ARM architecture version.
 			# On ARM v8 64-bit this property is required and must
-			  be one of:
-			   - "psci" (see bindings in [2])
+			  be:
+			   - "psci"
 			# On ARM 32-bit systems this property is optional
 
 The nodes describing the idle states (state) can only be defined within the
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 2c5db03f226c..b2b7ced633cf 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -63,7 +63,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index c51950f4a1b6..ab77adb4f3c2 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -63,7 +63,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 2b2bf39c30ef..1fb5c5a0f32e 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -62,7 +62,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 205f0f4c5df0..3a2784117139 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -79,7 +79,7 @@
 		 * PSCI node is not added default, U-boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 1109f22bda5e..e238b86e95fb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -121,7 +121,7 @@
 		 * PSCI node is not added default, U-boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 136ebfa9b333..1b200f7be0ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -117,7 +117,7 @@
 		 * PSCI node is not added default, U-boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 6d8532af8346..75cc0f7cc088 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -119,7 +119,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 3f5160d2f130..48f5928ed45c 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -114,7 +114,7 @@
 	};
 
 	idle-states{
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CORE_PD: core_pd {
 			compatible = "arm,idle-state";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a091e6f03014..29ce23422acf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -58,7 +58,7 @@
 		};
 
 		idle-states {
-			entry-method = "arm,psci";
+			entry-method = "psci";
 
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
-- 
2.17.1
