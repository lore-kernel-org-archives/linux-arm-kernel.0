From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 18:04:35 +0200
Subject: [PATCH v3 21/23] arm64: dts: marvell: add thermal-zone node in ap806
 DTSI file
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Message-ID: <20180705160437.12325-22-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a thermal-zone node and fill in all the sensors available in an
ap806 (one in the IC plus one per CPU).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 60 +++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 45662fc09d18..fe56c044c8f0 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 
 /dts-v1/;
 
@@ -267,8 +268,67 @@
 				ap_thermal: thermal-sensor at 80 {
 					compatible = "marvell,armada-ap806-thermal";
 					reg = <0x80 0x10>;
+					#thermal-sensor-cells = <1>;
 				};
 			};
 		};
 	};
+
+	/*
+	 * The thermal IP features one internal sensor plus, if applicable, one
+	 * remote channel wired to one sensor per CPU.
+	 *
+	 * The cooling maps are always empty as there are no cooling devices.
+	 */
+	thermal-zones {
+		ap_thermal_ic: ap-thermal-ic {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 0>;
+
+			trips {	};
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu1: ap-thermal-cpu1 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 1>;
+
+			trips { };
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu2: ap-thermal-cpu2 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 2>;
+
+			trips { };
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu3: ap-thermal-cpu3 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 3>;
+
+			trips { };
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu4: ap-thermal-cpu4 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 4>;
+
+			trips { };
+			cooling-maps { };
+		};
+	};
 };
-- 
2.14.1
