From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 14:10:06 +0800
Subject: [RFC 2/7] ARM: dts: sun9i: Add CCI-400 device nodes for A80
In-Reply-To: <1431583811-25780-1-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
Message-ID: <1431583811-25780-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 includes an ARM CCI-400 interconnect to support multi-cluster
CPU caches.

Also add the default clock frequency for the CPUs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index ca272e92b85d..200e712fbf0e 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -58,48 +58,64 @@
 		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			cci-control-port = <&cci_control0>;
+			clock-frequency = <12000000>;
 			reg = <0x0>;
 		};
 
 		cpu1: cpu at 1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			cci-control-port = <&cci_control0>;
+			clock-frequency = <12000000>;
 			reg = <0x1>;
 		};
 
 		cpu2: cpu at 2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			cci-control-port = <&cci_control0>;
+			clock-frequency = <12000000>;
 			reg = <0x2>;
 		};
 
 		cpu3: cpu at 3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			cci-control-port = <&cci_control0>;
+			clock-frequency = <12000000>;
 			reg = <0x3>;
 		};
 
 		cpu4: cpu at 100 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
+			cci-control-port = <&cci_control1>;
+			clock-frequency = <9000000>;
 			reg = <0x100>;
 		};
 
 		cpu5: cpu at 101 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
+			cci-control-port = <&cci_control1>;
+			clock-frequency = <9000000>;
 			reg = <0x101>;
 		};
 
 		cpu6: cpu at 102 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
+			cci-control-port = <&cci_control1>;
+			clock-frequency = <9000000>;
 			reg = <0x102>;
 		};
 
 		cpu7: cpu at 103 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
+			cci-control-port = <&cci_control1>;
+			clock-frequency = <9000000>;
 			reg = <0x103>;
 		};
 	};
@@ -522,6 +538,36 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		cci: cci at 01c90000 {
+			compatible = "arm,cci-400";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x01c90000 0x1000>;
+			ranges = <0x0 0x01c90000 0x10000>;
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
+				 compatible = "arm,cci-400-pmu,r1";
+				 reg = <0x9000 0x5000>;
+				 interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		ahb0_resets: reset at 060005a0 {
 			#reset-cells = <1>;
 			compatible = "allwinner,sun6i-a31-clock-reset";
-- 
2.1.4
