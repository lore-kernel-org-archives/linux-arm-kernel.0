From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  3 Jul 2015 08:11:57 +0200
Subject: [PATCH RFC 5/5] ARM: mvebu: Update Armada 38x DT for dynamic
 frequency scaling
In-Reply-To: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
References: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1435903917-20486-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support dynamic frequency scaling:

- the cpuclk Device Tree node must be added

- the clock property of the CPUs must be filled including the
  clock-latency property.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi | 3 +++
 arch/arm/boot/dts/armada-385.dtsi | 6 ++++++
 arch/arm/boot/dts/armada-38x.dtsi | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 5102d19cc8f4..f9dbc75bea73 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -61,6 +61,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
+			clock-names = "cpu0";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 8e67d2c083dd..62660dd377be 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -61,11 +61,17 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
+			clock-names = "cpu0";
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
+			clock-names = "cpu1";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 04ecfe6e2bc6..08409e92f3f3 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -369,6 +369,15 @@
 				#clock-cells = <1>;
 			};
 
+			cpuclk: clock-complex at 18700 {
+				compatible = "marvell,armada-380-cpu-clock",
+				"marvell,armada-xp-cpu-clock";
+				reg = <0x18700 0xA0>, <0x1c054 0x40>,
+				<0xe4260 0x8>;
+				clocks = <&coreclk 1>;
+				#clock-cells = <1>;
+			};
+
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
 				reg = <0x20000 0x100>, <0x20180 0x20>;
-- 
2.1.0
