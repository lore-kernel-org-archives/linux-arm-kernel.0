From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 27 Feb 2014 08:13:45 +0900
Subject: [PATCH 02/02] ARM: shmobile: Add CCI nodes to r8a7790 DTS
In-Reply-To: <20140226231326.4303.71886.sendpatchset@w520>
References: <20140226231326.4303.71886.sendpatchset@w520>
Message-ID: <20140226231345.4303.19244.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CCI nodes to the r8a7790 SoC DTSI file.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2014-02-27 07:59:13.000000000 +0900
@@ -35,6 +35,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu1: cpu at 1 {
@@ -42,6 +43,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu2: cpu at 2 {
@@ -49,6 +51,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu3: cpu at 3 {
@@ -56,6 +59,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu4: cpu at 4 {
@@ -63,6 +67,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu5: cpu at 5 {
@@ -70,6 +75,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu6: cpu at 6 {
@@ -77,6 +83,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu7: cpu at 7 {
@@ -84,6 +91,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 	};
 
@@ -99,6 +107,26 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	cci at f0090000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0xf0090000 0 0x1000>;
+		ranges = <0x0 0x0 0xf0090000 0x10000>;
+
+		cci_control1: slave-if at 4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control2: slave-if at 5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+	};
+
 	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
