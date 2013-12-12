From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 15:25:19 +0000
Subject: [PATCH 4/4] ARM: mvebu: sort DT nodes by address
In-Reply-To: <cover.1386861599.git.jason@lakedaemon.net>
References: <cover.1386861599.git.jason@lakedaemon.net>
Message-ID: <a095b1c78a35f05755ca2f0e106d84792974aef5.1386861599.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent future unnecessary merge conflicts

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 176 +++++++++++++++++------------------
 arch/arm/boot/dts/armada-370.dtsi    |  74 +++++++--------
 arch/arm/boot/dts/armada-xp.dtsi     | 100 ++++++++++----------
 3 files changed, 175 insertions(+), 175 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index f2b6ae4f55d0..46a541e626e7 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -103,22 +103,52 @@
 			#size-cells = <1>;
 			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
 
-			mbusc: mbus-controller at 20000 {
-				compatible = "marvell,mbus-controller";
-				reg = <0x20000 0x100>, <0x20180 0x20>;
+			rtc at 10300 {
+				compatible = "marvell,orion-rtc";
+				reg = <0x10300 0x20>;
+				interrupts = <50>;
 			};
 
-			mpic: interrupt-controller at 20000 {
-				compatible = "marvell,mpic";
-				#interrupt-cells = <1>;
-				#size-cells = <1>;
-				interrupt-controller;
-				msi-controller;
+			spi0: spi at 10600 {
+				compatible = "marvell,orion-spi";
+				reg = <0x10600 0x28>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				interrupts = <30>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
 			};
 
-			coherency-fabric at 20200 {
-				compatible = "marvell,coherency-fabric";
-				reg = <0x20200 0xb0>, <0x21810 0x1c>;
+			spi1: spi at 10680 {
+				compatible = "marvell,orion-spi";
+				reg = <0x10680 0x28>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <1>;
+				interrupts = <92>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			i2c0: i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <31>;
+				timeout-ms = <1000>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 11100 {
+				compatible = "marvell,mv64xxx-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <32>;
+				timeout-ms = <1000>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
 			};
 
 			serial at 12000 {
@@ -146,25 +176,41 @@
 				clock-output-names = "nand";
 			};
 
+			mbusc: mbus-controller at 20000 {
+				compatible = "marvell,mbus-controller";
+				reg = <0x20000 0x100>, <0x20180 0x20>;
+			};
+
+			mpic: interrupt-controller at 20000 {
+				compatible = "marvell,mpic";
+				#interrupt-cells = <1>;
+				#size-cells = <1>;
+				interrupt-controller;
+				msi-controller;
+			};
+
+			coherency-fabric at 20200 {
+				compatible = "marvell,coherency-fabric";
+				reg = <0x20200 0xb0>, <0x21810 0x1c>;
+			};
+
 			timer at 20300 {
 				reg = <0x20300 0x30>, <0x21040 0x30>;
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			};
 
-			sata at a0000 {
-				compatible = "marvell,orion-sata";
-				reg = <0xa0000 0x5000>;
-				interrupts = <55>;
-				clocks = <&gateclk 15>, <&gateclk 30>;
-				clock-names = "0", "1";
+			usb at 50000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x50000 0x500>;
+				interrupts = <45>;
 				status = "disabled";
 			};
 
-			mdio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "marvell,orion-mdio";
-				reg = <0x72004 0x4>;
+			usb at 51000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x51000 0x500>;
+				interrupts = <46>;
+				status = "disabled";
 			};
 
 			eth0: ethernet at 70000 {
@@ -175,6 +221,13 @@
 				status = "disabled";
 			};
 
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "marvell,orion-mdio";
+				reg = <0x72004 0x4>;
+			};
+
 			eth1: ethernet at 74000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x74000 0x4000>;
@@ -183,32 +236,25 @@
 				status = "disabled";
 			};
 
-			i2c0: i2c at 11000 {
-				compatible = "marvell,mv64xxx-i2c";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <31>;
-				timeout-ms = <1000>;
-				clocks = <&coreclk 0>;
+			sata at a0000 {
+				compatible = "marvell,orion-sata";
+				reg = <0xa0000 0x5000>;
+				interrupts = <55>;
+				clocks = <&gateclk 15>, <&gateclk 30>;
+				clock-names = "0", "1";
 				status = "disabled";
 			};
 
-			i2c1: i2c at 11100 {
-				compatible = "marvell,mv64xxx-i2c";
+			nand at d0000 {
+				compatible = "marvell,armada370-nand";
+				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <32>;
-				timeout-ms = <1000>;
-				clocks = <&coreclk 0>;
+				#size-cells = <1>;
+				interrupts = <113>;
+				clocks = <&coredivclk 0>;
 				status = "disabled";
 			};
 
-			rtc at 10300 {
-				compatible = "marvell,orion-rtc";
-				reg = <0x10300 0x20>;
-				interrupts = <50>;
-			};
-
 			mvsdio at d4000 {
 				compatible = "marvell,orion-sdio";
 				reg = <0xd4000 0x200>;
@@ -220,52 +266,6 @@
 				cap-mmc-highspeed;
 				status = "disabled";
 			};
-
-			usb at 50000 {
-				compatible = "marvell,orion-ehci";
-				reg = <0x50000 0x500>;
-				interrupts = <45>;
-				status = "disabled";
-			};
-
-			usb at 51000 {
-				compatible = "marvell,orion-ehci";
-				reg = <0x51000 0x500>;
-				interrupts = <46>;
-				status = "disabled";
-			};
-
-			spi0: spi at 10600 {
-				compatible = "marvell,orion-spi";
-				reg = <0x10600 0x28>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <0>;
-				interrupts = <30>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			spi1: spi at 10680 {
-				compatible = "marvell,orion-spi";
-				reg = <0x10680 0x28>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				cell-index = <1>;
-				interrupts = <92>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			nand at d0000 {
-				compatible = "marvell,armada370-nand";
-				reg = <0xd0000 0x54>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				interrupts = <113>;
-				clocks = <&coredivclk 0>;
-				status = "disabled";
-			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 7a4b82e71aaf..0d8530c98cf5 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -91,11 +91,6 @@
 		};
 
 		internal-regs {
-			system-controller at 18200 {
-				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0x18200 0x100>;
-			};
-
 			L2: l2-cache {
 				compatible = "marvell,aurora-outer-cache";
 				reg = <0x08000 0x1000>;
@@ -103,8 +98,17 @@
 				wt-override;
 			};
 
-			interrupt-controller at 20000 {
-				reg = <0x20a00 0x1d0>, <0x21870 0x58>;
+			i2c0: i2c at 11000 {
+				reg = <0x11000 0x20>;
+			};
+
+			i2c1: i2c at 11100 {
+				reg = <0x11100 0x20>;
+			};
+
+			system-controller at 18200 {
+				compatible = "marvell,armada-370-xp-system-controller";
+				reg = <0x18200 0x100>;
 			};
 
 			pinctrl {
@@ -163,9 +167,11 @@
 				interrupts = <91>;
 			};
 
-			timer at 20300 {
-				compatible = "marvell,armada-370-timer";
-				clocks = <&coreclk 2>;
+			gateclk: clock-gating-control at 18220 {
+				compatible = "marvell,armada-370-gating-clock";
+				reg = <0x18220 0x4>;
+				clocks = <&coreclk 0>;
+				#clock-cells = <1>;
 			};
 
 			coreclk: mvebu-sar at 18230 {
@@ -174,11 +180,28 @@
 				#clock-cells = <1>;
 			};
 
-			gateclk: clock-gating-control at 18220 {
-				compatible = "marvell,armada-370-gating-clock";
-				reg = <0x18220 0x4>;
+			thermal at 18300 {
+				compatible = "marvell,armada370-thermal";
+				reg = <0x18300 0x4
+					0x18304 0x4>;
+				status = "okay";
+			};
+
+			interrupt-controller at 20000 {
+				reg = <0x20a00 0x1d0>, <0x21870 0x58>;
+			};
+
+			timer at 20300 {
+				compatible = "marvell,armada-370-timer";
+				clocks = <&coreclk 2>;
+			};
+
+			usb at 50000 {
+				clocks = <&coreclk 0>;
+			};
+
+			usb at 51000 {
 				clocks = <&coreclk 0>;
-				#clock-cells = <1>;
 			};
 
 			xor at 60800 {
@@ -218,29 +241,6 @@
 					dmacap,memset;
 				};
 			};
-
-			i2c0: i2c at 11000 {
-				reg = <0x11000 0x20>;
-			};
-
-			i2c1: i2c at 11100 {
-				reg = <0x11100 0x20>;
-			};
-
-			usb at 50000 {
-				clocks = <&coreclk 0>;
-			};
-
-			usb at 51000 {
-				clocks = <&coreclk 0>;
-			};
-
-			thermal at 18300 {
-				compatible = "marvell,armada370-thermal";
-				reg = <0x18300 0x4
-					0x18304 0x4>;
-				status = "okay";
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 281c6447e872..4919fb82ac62 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -42,13 +42,14 @@
 				wt-override;
 			};
 
-			interrupt-controller at 20000 {
-			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
+			i2c0: i2c at 11000 {
+				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+				reg = <0x11000 0x100>;
 			};
 
-			armada-370-xp-pmsu at 22000 {
-				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x430>, <0x20800 0x20>;
+			i2c1: i2c at 11100 {
+				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+				reg = <0x11100 0x100>;
 			};
 
 			serial at 12200 {
@@ -68,10 +69,16 @@
 				status = "disabled";
 			};
 
-			timer at 20300 {
-				compatible = "marvell,armada-xp-timer";
-				clocks = <&coreclk 2>, <&refclk>;
-				clock-names = "nbclk", "fixed";
+			system-controller at 18200 {
+				compatible = "marvell,armada-370-xp-system-controller";
+				reg = <0x18200 0x500>;
+			};
+
+			gateclk: clock-gating-control at 18220 {
+				compatible = "marvell,armada-xp-gating-clock";
+				reg = <0x18220 0x4>;
+				clocks = <&coreclk 0>;
+				#clock-cells = <1>;
 			};
 
 			coreclk: mvebu-sar at 18230 {
@@ -80,6 +87,13 @@
 				#clock-cells = <1>;
 			};
 
+			thermal at 182b0 {
+				compatible = "marvell,armadaxp-thermal";
+				reg = <0x182b0 0x4
+					0x184d0 0x4>;
+				status = "okay";
+			};
+
 			cpuclk: clock-complex at 18700 {
 				#clock-cells = <1>;
 				compatible = "marvell,armada-xp-cpu-clock";
@@ -87,16 +101,19 @@
 				clocks = <&coreclk 1>;
 			};
 
-			gateclk: clock-gating-control at 18220 {
-				compatible = "marvell,armada-xp-gating-clock";
-				reg = <0x18220 0x4>;
-				clocks = <&coreclk 0>;
-				#clock-cells = <1>;
+			interrupt-controller at 20000 {
+			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
 			};
 
-			system-controller at 18200 {
-				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0x18200 0x500>;
+			timer at 20300 {
+				compatible = "marvell,armada-xp-timer";
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
+			armada-370-xp-pmsu at 22000 {
+				compatible = "marvell,armada-370-xp-pmsu";
+				reg = <0x22100 0x430>, <0x20800 0x20>;
 			};
 
 			eth2: ethernet at 30000 {
@@ -107,6 +124,22 @@
 				status = "disabled";
 			};
 
+			usb at 50000 {
+				clocks = <&gateclk 18>;
+			};
+
+			usb at 51000 {
+				clocks = <&gateclk 19>;
+			};
+
+			usb at 52000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x52000 0x500>;
+				interrupts = <47>;
+				clocks = <&gateclk 20>;
+				status = "disabled";
+			};
+
 			xor at 60900 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60900 0x100
@@ -146,39 +179,6 @@
 					dmacap,memset;
 				};
 			};
-
-			i2c0: i2c@11000 {
-				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
-				reg = <0x11000 0x100>;
-			};
-
-			i2c1: i2c at 11100 {
-				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
-				reg = <0x11100 0x100>;
-			};
-
-			usb at 50000 {
-				clocks = <&gateclk 18>;
-			};
-
-			usb at 51000 {
-				clocks = <&gateclk 19>;
-			};
-
-			usb at 52000 {
-				compatible = "marvell,orion-ehci";
-				reg = <0x52000 0x500>;
-				interrupts = <47>;
-				clocks = <&gateclk 20>;
-				status = "disabled";
-			};
-
-			thermal at 182b0 {
-				compatible = "marvell,armadaxp-thermal";
-				reg = <0x182b0 0x4
-					0x184d0 0x4>;
-				status = "okay";
-			};
 		};
 	};
 
-- 
1.8.5.1
