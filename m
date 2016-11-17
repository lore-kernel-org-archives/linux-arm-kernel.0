From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:53 +0100
Subject: [PATCH v3 04/19] ARM: dts: armada-370-xp: Use the node labels
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the node label when possible. As a result it flattens the device tree
and it makes more visible the IP blocks specific to each SoC variant.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 105 +++++++++++++++++++-------------------
 arch/arm/boot/dts/armada-xp.dtsi  |  76 +++++++++++++--------------
 2 files changed, 91 insertions(+), 90 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 5ed086da1e51..079494e52554 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -134,14 +134,6 @@
 				wt-override;
 			};
 
-			i2c0: i2c at 11000 {
-				reg = <0x11000 0x20>;
-			};
-
-			i2c1: i2c at 11100 {
-				reg = <0x11100 0x20>;
-			};
-
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
@@ -175,20 +167,6 @@
 				interrupts = <91>;
 			};
 
-			/*
-			 * Default UART pinctrl setting without RTS/CTS, can
-			 * be overwritten on board level if a different
-			 * configuration is used.
-			 */
-			uart0: serial at 12000 {
-				pinctrl-0 = <&uart0_pins>;
-				pinctrl-names = "default";
-			};
-
-			uart1: serial at 12100 {
-				pinctrl-0 = <&uart1_pins>;
-				pinctrl-names = "default";
-			};
 
 			systemc: system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
@@ -219,20 +197,6 @@
 				reg = <0x18330 0x4>;
 			};
 
-			interrupt-controller at 20a00 {
-				reg = <0x20a00 0x1d0>, <0x21870 0x58>;
-			};
-
-			timer at 20300 {
-				compatible = "marvell,armada-370-timer";
-				clocks = <&coreclk 2>;
-			};
-
-			watchdog at 20300 {
-				compatible = "marvell,armada-370-wdt";
-				clocks = <&coreclk 2>;
-			};
-
 			cpuconf: cpu-config at 21000 {
 				compatible = "marvell,armada-370-cpu-config";
 				reg = <0x21000 0x8>;
@@ -248,14 +212,6 @@
 				status = "disabled";
 			};
 
-			usb at 50000 {
-				clocks = <&coreclk 0>;
-			};
-
-			usb at 51000 {
-				clocks = <&coreclk 0>;
-			};
-
 			xor0: xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
@@ -294,14 +250,6 @@
 				};
 			};
 
-			ethernet at 70000 {
-				compatible = "marvell,armada-370-neta";
-			};
-
-			ethernet at 74000 {
-				compatible = "marvell,armada-370-neta";
-			};
-
 			cesa: crypto@90000 {
 				compatible = "marvell,armada-370-crypto";
 				reg = <0x90000 0x10000>;
@@ -337,6 +285,59 @@
 	};
 };
 
+/*
+ * Default UART pinctrl setting without RTS/CTS, can be overwritten on
+ * board level if a different configuration is used.
+ */
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+};
+
+&i2c0 {
+	reg = <0x11000 0x20>;
+};
+
+&i2c1 {
+	reg = <0x11100 0x20>;
+};
+
+&mpic {
+	reg = <0x20a00 0x1d0>, <0x21870 0x58>;
+};
+
+&timer {
+	compatible = "marvell,armada-370-timer";
+	clocks = <&coreclk 2>;
+};
+
+&watchdog {
+	compatible = "marvell,armada-370-wdt";
+	clocks = <&coreclk 2>;
+};
+
+&usb0 {
+	clocks = <&coreclk 0>;
+};
+
+&usb1 {
+	clocks = <&coreclk 0>;
+};
+
+&eth0 {
+	compatible = "marvell,armada-370-neta";
+};
+
+&eth1 {
+	compatible = "marvell,armada-370-neta";
+};
+
 &pinctrl {
 	compatible = "marvell,mv88f6710-pinctrl";
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 654a61e525b4..bb8f7dcaf656 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -84,16 +84,6 @@
 				wt-override;
 			};
 
-			i2c0: i2c at 11000 {
-				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
-				reg = <0x11000 0x100>;
-			};
-
-			i2c1: i2c at 11100 {
-				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
-				reg = <0x11100 0x100>;
-			};
-
 			uart2: serial at 12200 {
 				compatible = "snps,dw-apb-uart";
 				pinctrl-0 = <&uart2_pins>;
@@ -150,26 +140,6 @@
 				clocks = <&coreclk 1>;
 			};
 
-			interrupt-controller at 20a00 {
-			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
-			};
-
-			timer at 20300 {
-				compatible = "marvell,armada-xp-timer";
-				clocks = <&coreclk 2>, <&refclk>;
-				clock-names = "nbclk", "fixed";
-			};
-
-			watchdog at 20300 {
-				compatible = "marvell,armada-xp-wdt";
-				clocks = <&coreclk 2>, <&refclk>;
-				clock-names = "nbclk", "fixed";
-			};
-
-			cpurst at 20800 {
-				reg = <0x20800 0x20>;
-			};
-
 			cpu-config at 21000 {
 				compatible = "marvell,armada-xp-cpu-config";
 				reg = <0x21000 0x8>;
@@ -183,14 +153,6 @@
 				status = "disabled";
 			};
 
-			usb at 50000 {
-				clocks = <&gateclk 18>;
-			};
-
-			usb at 51000 {
-				clocks = <&gateclk 19>;
-			};
-
 			usb2: usb at 52000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x52000 0x500>;
@@ -308,6 +270,44 @@
 	};
 };
 
+&i2c0 {
+	compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+	reg = <0x11000 0x100>;
+};
+
+&i2c1 {
+	compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+	reg = <0x11100 0x100>;
+};
+
+&mpic {
+	reg = <0x20a00 0x2d0>, <0x21070 0x58>;
+};
+
+&timer {
+	compatible = "marvell,armada-xp-timer";
+	clocks = <&coreclk 2>, <&refclk>;
+	clock-names = "nbclk", "fixed";
+};
+
+&watchdog {
+	compatible = "marvell,armada-xp-wdt";
+	clocks = <&coreclk 2>, <&refclk>;
+	clock-names = "nbclk", "fixed";
+};
+
+&cpurst {
+	reg = <0x20800 0x20>;
+};
+
+&usb0 {
+	clocks = <&gateclk 18>;
+};
+
+&usb1 {
+	clocks = <&gateclk 19>;
+};
+
 &pinctrl {
 	ge0_gmii_pins: ge0-gmii-pins {
 		marvell,pins =
-- 
2.10.2
