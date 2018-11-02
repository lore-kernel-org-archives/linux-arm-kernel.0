From: andy.tang@nxp.com (Yuantian Tang)
Date: Fri,  2 Nov 2018 11:11:15 +0800
Subject: [PATCH] arm64: dts: nxp: add more thermal zone support
Message-ID: <20181102031115.3818-1-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable all the supported thermal sensors, add sensor id information
to thermal zone node.
Dts for ls1012a, ls1046a, ls1043a, ls1088a are updated.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   39 +++------------
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   59 +++++++++++------------
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   55 ++++++++++------------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   54 ++++++----------------
 4 files changed, 75 insertions(+), 132 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 68ac78c..9526b66 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -28,7 +28,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu0: cpu at 0 {
+		cooling_map0: cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
@@ -100,36 +100,7 @@
 		mask = <0x02>;
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	soc {
 		compatible = "simple-bus";
@@ -506,3 +477,9 @@
 		};
 	};
 };
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7881e3d..3afc6d4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -37,7 +37,7 @@
 		 *
 		 * Currently supported enable-method is psci v0.2
 		 */
-		cpu0: cpu at 0 {
+		cooling_map0: cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
@@ -146,36 +146,7 @@
 		mask = <0x02>;
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-
-			thermal-sensors = <&tmu 3>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	timer {
 		compatible = "arm,armv8-timer";
@@ -747,3 +718,29 @@
 
 #include "qoriq-qman-portals.dtsi"
 #include "qoriq-bman-portals.dtsi"
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+
+	thermal-zone1 {
+		status = "okay";
+	};
+
+	thermal-zone2 {
+		status = "okay";
+	};
+
+	thermal-zone3 {
+		status = "okay";
+	};
+
+	thermal-zone4 {
+		status = "okay";
+	};
+
+	thermal-zone5 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index ef83786..11793ca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -33,7 +33,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu0: cpu at 0 {
+		cooling_map0: cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x0>;
@@ -115,36 +115,7 @@
 		mask = <0x02>;
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-			thermal-sensors = <&tmu 3>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	timer {
 		compatible = "arm,armv8-timer";
@@ -743,3 +714,25 @@
 
 #include "qoriq-qman-portals.dtsi"
 #include "qoriq-bman-portals.dtsi"
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+
+	thermal-zone1 {
+		status = "okay";
+	};
+
+	thermal-zone2 {
+		status = "okay";
+	};
+
+	thermal-zone3 {
+		status = "okay";
+	};
+
+	thermal-zone4 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612..d47f1a0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -25,7 +25,7 @@
 		#size-cells = <0>;
 
 		/* We have 2 clusters having 4 Cortex-A53 cores each */
-		cpu0: cpu at 0 {
+		cooling_map0: cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
@@ -61,7 +61,7 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu4: cpu at 100 {
+		cooling_map1: cpu4: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x100>;
@@ -128,43 +128,7 @@
 		};
 	};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
-			polling-delay = <5000>;
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu4 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
+	#include "fsl-tmu.dtsi"
 
 	timer {
 		compatible = "arm,armv8-timer";
@@ -648,3 +612,15 @@
 	};
 
 };
+
+#include "fsl-tmu-map1.dtsi"
+
+&thermal_zones {
+	thermal-zone0 {
+		status = "okay";
+	};
+
+	thermal-zone1 {
+		status = "okay";
+	};
+};
-- 
1.7.1
