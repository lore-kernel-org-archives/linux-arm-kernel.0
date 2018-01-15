From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Jan 2018 15:14:44 +0800
Subject: [PATCH v3 2/8] ARM: dts: sun9i: Add CCI-400 device nodes for A80
In-Reply-To: <20180115071450.18355-1-wens@csie.org>
References: <20180115071450.18355-1-wens@csie.org>
Message-ID: <20180115071450.18355-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 includes an ARM CCI-400 interconnect to support multi-cluster
CPU caches.

Also add the maximum clock frequency for the CPUs, as listed in the
A80 Optimus Board FEX file.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 90eac0b2a193..85fb800af8ab 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -63,48 +63,64 @@
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
+			clock-frequency = <18000000>;
 			reg = <0x100>;
 		};
 
 		cpu5: cpu at 101 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
+			cci-control-port = <&cci_control1>;
+			clock-frequency = <18000000>;
 			reg = <0x101>;
 		};
 
 		cpu6: cpu at 102 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
+			cci-control-port = <&cci_control1>;
+			clock-frequency = <18000000>;
 			reg = <0x102>;
 		};
 
 		cpu7: cpu at 103 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
+			cci-control-port = <&cci_control1>;
+			clock-frequency = <18000000>;
 			reg = <0x103>;
 		};
 	};
@@ -431,6 +447,36 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		cci: cci at 1c90000 {
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
 		de_clocks: clock at 3000000 {
 			compatible = "allwinner,sun9i-a80-de-clks";
 			reg = <0x03000000 0x30>;
-- 
2.15.1
