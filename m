From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  1 May 2018 14:31:24 +0200
Subject: [PATCH v8 05/12] ARM: dts: sun8i: a83t: Add CCI-400 node
In-Reply-To: <20180501123131.7738-1-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
Message-ID: <20180501123131.7738-6-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CCI-400 node and control-port on CPUs needed by SMP bringup.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 53ace066b7dc..0669b8dc499d 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -66,6 +66,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			cci-control-port = <&cci_control0>;
 			reg = <0>;
 		};
 
@@ -73,6 +74,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			cci-control-port = <&cci_control0>;
 			reg = <1>;
 		};
 
@@ -80,6 +82,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			cci-control-port = <&cci_control0>;
 			reg = <2>;
 		};
 
@@ -87,6 +90,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			cci-control-port = <&cci_control0>;
 			reg = <3>;
 		};
 
@@ -96,6 +100,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
+			cci-control-port = <&cci_control1>;
 			reg = <0x100>;
 		};
 
@@ -103,6 +108,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
+			cci-control-port = <&cci_control1>;
 			reg = <0x101>;
 		};
 
@@ -110,6 +116,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
+			cci-control-port = <&cci_control1>;
 			reg = <0x102>;
 		};
 
@@ -117,6 +124,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
+			cci-control-port = <&cci_control1>;
 			reg = <0x103>;
 		};
 	};
@@ -354,6 +362,39 @@
 			reg = <0x01700000 0x400>;
 		};
 
+		cci at 1790000 {
+			compatible = "arm,cci-400";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x01790000 0x10000>;
+			ranges = <0x0 0x01790000 0x10000>;
+
+			cci_control0: slave-if at 4000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x4000 0x1000>;
+			};
+
+			cci_control1: slave-if at 5000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x5000 0x1000>;
+			};
+
+			pmu at 9000 {
+				compatible = "arm,cci-400-pmu,r1";
+				reg = <0x9000 0x5000>;
+				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun8i-a83t-system-controller",
 				"syscon";
-- 
2.11.0
