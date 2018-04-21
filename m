From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 17:12:53 +0200
Subject: [PATCH 25/27] arm64: dts: marvell: add thermal-zone node in cp110
 DTSI file
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Message-ID: <20180421151255.29929-26-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a thermal-zone node and fill in all the sensors available in a
cp110 (only one in the thermal IP).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 514780980847..8d0fc1bfe291 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "armada-common.dtsi"
 
@@ -19,6 +20,23 @@
 	 * save one indentation level
 	 */
 	CP110_NAME: CP110_NAME { };
+
+	/*
+	 * CPs only have one sensor in the thermal IC.
+	 *
+	 * The cooling maps are empty as there are no cooling devices.
+	 */
+	thermal-zones {
+		CP110_LABEL(thermal_ic): CP110_NODE_NAME(thermal-ic) {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&CP110_LABEL(thermal) 0>;
+
+			trips {	};
+			cooling-maps { };
+		};
+	};
 };
 
 &CP110_NAME {
@@ -216,6 +234,7 @@
 
 			CP110_LABEL(thermal): thermal at 400070 {
 				compatible = "marvell,armada-cp110-thermal";
+				#thermal-sensor-cells = <1>;
 			};
 		};
 
-- 
2.14.1
