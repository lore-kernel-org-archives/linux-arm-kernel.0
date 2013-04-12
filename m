From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Apr 2013 16:29:08 +0200
Subject: [PATCH v4 3/5] ARM: dts: mvebu: Convert all the mvebu files to use
 the range property
In-Reply-To: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365776950-30094-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This conversion will allow to keep 32 bits addresses for the internal
registers whereas the memory of the system will be 64 bits.
Later it will also ease the move of the mvebu-mbus driver to the
device tree support.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              |   16 ++--
 arch/arm/boot/dts/armada-370-mirabox.dts         |   16 ++--
 arch/arm/boot/dts/armada-370-rd.dts              |   14 +--
 arch/arm/boot/dts/armada-370-xp.dtsi             |   99 +++++++++++-----------
 arch/arm/boot/dts/armada-370.dtsi                |   65 +++++++-------
 arch/arm/boot/dts/armada-xp-db.dts               |   28 +++---
 arch/arm/boot/dts/armada-xp-gp.dts               |   22 ++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         |   30 +++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         |   44 +++++-----
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         |   58 ++++++-------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   24 +++---
 arch/arm/boot/dts/armada-xp.dtsi                 |   71 ++++++++--------
 12 files changed, 245 insertions(+), 242 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 6403acd..e766f8b 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -30,11 +30,11 @@
 	};
 
 	soc {
-		serial at d0012000 {
+		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
-		sata at d00a0000 {
+		sata at a0000 {
 			nr-ports = <2>;
 			status = "okay";
 		};
@@ -49,18 +49,18 @@
 			};
 		};
 
-		ethernet at d0070000 {
+		ethernet at 70000 {
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "rgmii-id";
 		};
-		ethernet at d0074000 {
+		ethernet at 74000 {
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
 
-		mvsdio at d00d4000 {
+		mvsdio at d4000 {
 			pinctrl-0 = <&sdio_pins1>;
 			pinctrl-names = "default";
 			/*
@@ -75,15 +75,15 @@
 			/* No CD or WP GPIOs */
 		};
 
-		usb at d0050000 {
+		usb at 50000 {
 			status = "okay";
 		};
 
-		usb at d0051000 {
+		usb at 51000 {
 			status = "okay";
 		};
 
-		spi0: spi at d0010600 {
+		spi0: spi at 10600 {
 			status = "okay";
 
 			spi-flash at 0 {
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 58ee793..6530ae3 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -25,11 +25,11 @@
 	};
 
 	soc {
-		serial at d0012000 {
+		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
-		timer at d0020300 {
+		timer at 20300 {
 			clock-frequency = <600000000>;
 			status = "okay";
 		};
@@ -79,18 +79,18 @@
 				reg = <1>;
 			};
 		};
-		ethernet at d0070000 {
+		ethernet at 70000 {
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "rgmii-id";
 		};
-		ethernet at d0074000 {
+		ethernet at 74000 {
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
 
-		mvsdio at d00d4000 {
+		mvsdio at d4000 {
 			pinctrl-0 = <&sdio_pins3>;
 			pinctrl-names = "default";
 			status = "okay";
@@ -100,15 +100,15 @@
 			 */
 		};
 
-		usb at d0050000 {
+		usb at 50000 {
 			status = "okay";
 		};
 
-		usb at d0051000 {
+		usb at 51000 {
 			status = "okay";
 		};
 
-		i2c at d0011000 {
+		i2c at 11000 {
 			status = "okay";
 			clock-frequency = <100000>;
 			pca9505: pca9505 at 25 {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 516dec3..83d5c04 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -28,11 +28,11 @@
 	};
 
 	soc {
-		serial at d0012000 {
+		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
-		sata at d00a0000 {
+		sata at a0000 {
 			nr-ports = <2>;
 			status = "okay";
 		};
@@ -47,29 +47,29 @@
 			};
 		};
 
-		ethernet at d0070000 {
+		ethernet at 70000 {
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "sgmii";
 		};
-		ethernet at d0074000 {
+		ethernet at 74000 {
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
 
-		mvsdio at d00d4000 {
+		mvsdio at d4000 {
 			pinctrl-0 = <&sdio_pins1>;
 			pinctrl-names = "default";
 			status = "okay";
 			/* No CD or WP GPIOs */
 		};
 
-		usb at d0050000 {
+		usb at 50000 {
 			status = "okay";
 		};
 
-		usb at d0051000 {
+		usb at 51000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 972448c..da40ce5 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -28,54 +28,55 @@
 		};
 	};
 
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		interrupt-parent = <&mpic>;
-		ranges;
+		ranges = <0 0xd0000000 0x100000>;
 
-		mpic: interrupt-controller at d0020000 {
-			compatible = "marvell,mpic";
-			#interrupt-cells = <1>;
-			#size-cells = <1>;
-			interrupt-controller;
+		mpic: interrupt-controller at 20000 {
+				compatible = "marvell,mpic";
+				#interrupt-cells = <1>;
+				#size-cells = <1>;
+				interrupt-controller;
 		};
 
-		coherency-fabric at d0020200 {
-			compatible = "marvell,coherency-fabric";
-			reg = <0xd0020200 0xb0>,
-			      <0xd0021810 0x1c>;
+		coherency-fabric at 20200 {
+				compatible = "marvell,coherency-fabric";
+				reg = <0x20200 0xb0>,
+				      <0x21810 0x1c>;
 		};
 
-		serial at d0012000 {
+		serial at 12000 {
 				compatible = "snps,dw-apb-uart";
-				reg = <0xd0012000 0x100>;
+				reg = <0x12000 0x100>;
 				reg-shift = <2>;
 				interrupts = <41>;
 				reg-io-width = <1>;
 				status = "disabled";
 		};
-		serial at d0012100 {
+		serial at 12100 {
 				compatible = "snps,dw-apb-uart";
-				reg = <0xd0012100 0x100>;
+				reg = <0x12100 0x100>;
 				reg-shift = <2>;
 				interrupts = <42>;
 				reg-io-width = <1>;
 				status = "disabled";
 		};
 
-		timer at d0020300 {
+		timer at 20300 {
 			       compatible = "marvell,armada-370-xp-timer";
-			       reg = <0xd0020300 0x30>,
-			       <0xd0021040 0x30>;
+			       reg = <0x20300 0x30>,
+			       <0x21040 0x30>;
 			       interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			       clocks = <&coreclk 2>;
 		};
 
-		sata at d00a0000 {
+		sata at a0000 {
 			compatible = "marvell,orion-sata";
-			reg = <0xd00a0000 0x2400>;
+			reg = <0xa0000 0x2400>;
 			interrupts = <55>;
 			clocks = <&gateclk 15>, <&gateclk 30>;
 			clock-names = "0", "1";
@@ -86,28 +87,28 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "marvell,orion-mdio";
-			reg = <0xd0072004 0x4>;
+			reg = <0x72004 0x4>;
 		};
 
-		ethernet at d0070000 {
+		ethernet at 70000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0xd0070000 0x2500>;
+				reg = <0x70000 0x2500>;
 				interrupts = <8>;
 				clocks = <&gateclk 4>;
 				status = "disabled";
 		};
 
-		ethernet at d0074000 {
+		ethernet at 74000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0xd0074000 0x2500>;
+				reg = <0x74000 0x2500>;
 				interrupts = <10>;
 				clocks = <&gateclk 3>;
 				status = "disabled";
 		};
 
-		i2c0: i2c at d0011000 {
+		i2c0: i2c at 11000 {
 			compatible = "marvell,mv64xxx-i2c";
-			reg = <0xd0011000 0x20>;
+			reg = <0x11000 0x20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <31>;
@@ -116,9 +117,9 @@
 			status = "disabled";
 		};
 
-		i2c1: i2c at d0011100 {
+		i2c1: i2c at 11100 {
 			compatible = "marvell,mv64xxx-i2c";
-			reg = <0xd0011100 0x20>;
+			reg = <0x11100 0x20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <32>;
@@ -129,35 +130,35 @@
 
 		rtc at 10300 {
 			compatible = "marvell,orion-rtc";
-			reg = <0xd0010300 0x20>;
+			reg = <0x10300 0x20>;
 			interrupts = <50>;
 		};
 
-		mvsdio at d00d4000 {
+		mvsdio at d4000 {
 			compatible = "marvell,orion-sdio";
-			reg = <0xd00d4000 0x200>;
+			reg = <0xd4000 0x200>;
 			interrupts = <54>;
 			clocks = <&gateclk 17>;
 			status = "disabled";
 		};
 
-		usb at d0050000 {
+		usb at 50000 {
 			compatible = "marvell,orion-ehci";
-			reg = <0xd0050000 0x500>;
+			reg = <0x50000 0x500>;
 			interrupts = <45>;
 			status = "disabled";
 		};
 
-		usb at d0051000 {
+		usb at 51000 {
 			compatible = "marvell,orion-ehci";
-			reg = <0xd0051000 0x500>;
+			reg = <0x51000 0x500>;
 			interrupts = <46>;
 			status = "disabled";
 		};
 
-		spi0: spi at d0010600 {
+		spi0: spi at 10600 {
 			compatible = "marvell,orion-spi";
-			reg = <0xd0010600 0x28>;
+			reg = <0x10600 0x28>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
@@ -166,9 +167,9 @@
 			status = "disabled";
 		};
 
-		spi1: spi at d0010680 {
+		spi1: spi at 10680 {
 			compatible = "marvell,orion-spi";
-			reg = <0xd0010680 0x28>;
+			reg = <0x10680 0x28>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <1>;
@@ -177,45 +178,45 @@
 			status = "disabled";
 		};
 
-		devbus-bootcs at d0010400 {
+		devbus-bootcs at 10400 {
 			compatible = "marvell,mvebu-devbus";
-			reg = <0xd0010400 0x8>;
+			reg = <0x10400 0x8>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
 
-		devbus-cs0 at d0010408 {
+		devbus-cs0 at 10408 {
 			compatible = "marvell,mvebu-devbus";
-			reg = <0xd0010408 0x8>;
+			reg = <0x10408 0x8>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
 
-		devbus-cs1 at d0010410 {
+		devbus-cs1 at 10410 {
 			compatible = "marvell,mvebu-devbus";
-			reg = <0xd0010410 0x8>;
+			reg = <0x10410 0x8>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
 
-		devbus-cs2 at d0010418 {
+		devbus-cs2 at 10418 {
 			compatible = "marvell,mvebu-devbus";
-			reg = <0xd0010418 0x8>;
+			reg = <0x10418 0x8>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
 
-		devbus-cs3 at d0010420 {
+		devbus-cs3 at 10420 {
 			compatible = "marvell,mvebu-devbus";
-			reg = <0xd0010420 0x8>;
+			reg = <0x10420 0x8>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			clocks = <&coreclk 0>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 209caeb..5c4fa65 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -28,14 +28,15 @@
 	};
 
 	soc {
-		mpic: interrupt-controller at d0020000 {
-			reg = <0xd0020a00 0x1d0>,
-			      <0xd0021870 0x58>;
+
+		mpic: interrupt-controller at 20000 {
+			reg = <0x20a00 0x1d0>,
+			      <0x21870 0x58>;
 		};
 
-		system-controller at d0018200 {
+		system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0xd0018200 0x100>;
+				reg = <0x18200 0x100>;
 		};
 
 		L2: l2-cache {
@@ -47,7 +48,7 @@
 
 		pinctrl {
 			compatible = "marvell,mv88f6710-pinctrl";
-			reg = <0xd0018000 0x38>;
+			reg = <0x18000 0x38>;
 
 			sdio_pins1: sdio-pins1 {
 			      marvell,pins = "mpp9",  "mpp11", "mpp12",
@@ -68,9 +69,9 @@
 			};
 	        };
 
-		gpio0: gpio at d0018100 {
+		gpio0: gpio at 18100 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018100 0x40>;
+			reg = <0x18100 0x40>;
 			ngpios = <32>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -79,9 +80,9 @@
 			interrupts = <82>, <83>, <84>, <85>;
 		};
 
-		gpio1: gpio at d0018140 {
+		gpio1: gpio at 18140 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018140 0x40>;
+			reg = <0x18140 0x40>;
 			ngpios = <32>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -90,9 +91,9 @@
 			interrupts = <87>, <88>, <89>, <90>;
 		};
 
-		gpio2: gpio at d0018180 {
+		gpio2: gpio at 18180 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018180 0x40>;
+			reg = <0x18180 0x40>;
 			ngpios = <2>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -101,23 +102,23 @@
 			interrupts = <91>;
 		};
 
-		coreclk: mvebu-sar at d0018230 {
+		coreclk: mvebu-sar at 18230 {
 			compatible = "marvell,armada-370-core-clock";
-			reg = <0xd0018230 0x08>;
+			reg = <0x18230 0x08>;
 			#clock-cells = <1>;
 		};
 
-		gateclk: clock-gating-control at d0018220 {
+		gateclk: clock-gating-control at 18220 {
 			compatible = "marvell,armada-370-gating-clock";
-			reg = <0xd0018220 0x4>;
+			reg = <0x18220 0x4>;
 			clocks = <&coreclk 0>;
 			#clock-cells = <1>;
 		};
 
-		xor at d0060800 {
+		xor at 60800 {
 			compatible = "marvell,orion-xor";
-			reg = <0xd0060800 0x100
-			       0xd0060A00 0x100>;
+			reg = <0x60800 0x100
+			       0x60A00 0x100>;
 			status = "okay";
 
 			xor00 {
@@ -133,10 +134,10 @@
 			};
 		};
 
-		xor at d0060900 {
+		xor at 60900 {
 			compatible = "marvell,orion-xor";
-			reg = <0xd0060900 0x100
-			       0xd0060b00 0x100>;
+			reg = <0x60900 0x100
+			       0x60b00 0x100>;
 			status = "okay";
 
 			xor10 {
@@ -152,18 +153,18 @@
 			};
 		};
 
-		usb at d0050000 {
+		usb at 50000 {
 			clocks = <&coreclk 0>;
 		};
 
-		usb at d0051000 {
+		usb at 51000 {
 			clocks = <&coreclk 0>;
 		};
 
-		thermal at d0018300 {
+		thermal at 18300 {
 			compatible = "marvell,armada370-thermal";
-			reg = <0xd0018300 0x4
-			       0xd0018304 0x4>;
+			reg = <0x18300 0x4
+			       0x18304 0x4>;
 			status = "okay";
 		};
 
@@ -177,18 +178,18 @@
 
 			bus-range = <0x00 0xff>;
 
-			reg = <0xd0040000 0x2000>, <0xd0080000 0x2000>;
+			reg = <0x40000 0x2000>, <0x80000 0x2000>;
 
 			reg-names = "pcie0.0", "pcie1.0";
 
-			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
-				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000   /* Port 1.0 registers */
+			ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0x80000 0x80000 0 0x00002000   /* Port 1.0 registers */
 				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
 			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
 
 			pcie at 1,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -204,7 +205,7 @@
 
 			pcie at 2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82002800 0 0xd0080000 0 0x2000>;
+				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 54cc5bb..e37863f 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -30,24 +30,24 @@
 	};
 
 	soc {
-		serial at d0012000 {
+		serial at 12000 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
-		serial at d0012100 {
+		serial at 12100 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
-		serial at d0012200 {
+		serial at 12200 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
-		serial at d0012300 {
+		serial at 12300 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
 
-		sata at d00a0000 {
+		sata at a0000 {
 			nr-ports = <2>;
 			status = "okay";
 		};
@@ -70,47 +70,47 @@
 			};
 		};
 
-		ethernet at d0070000 {
+		ethernet at 70000 {
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "rgmii-id";
 		};
-		ethernet at d0074000 {
+		ethernet at 74000 {
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
-		ethernet at d0030000 {
+		ethernet at 30000 {
 			status = "okay";
 			phy = <&phy2>;
 			phy-mode = "sgmii";
 		};
-		ethernet at d0034000 {
+		ethernet at 34000 {
 			status = "okay";
 			phy = <&phy3>;
 			phy-mode = "sgmii";
 		};
 
-		mvsdio at d00d4000 {
+		mvsdio at d4000 {
 			pinctrl-0 = <&sdio_pins>;
 			pinctrl-names = "default";
 			status = "okay";
 			/* No CD or WP GPIOs */
 		};
 
-		usb at d0050000 {
+		usb at 50000 {
 			status = "okay";
 		};
 
-		usb at d0051000 {
+		usb at 51000 {
 			status = "okay";
 		};
 
-		usb at d0052000 {
+		usb at 52000 {
 			status = "okay";
 		};
 
-		spi0: spi at d0010600 {
+		spi0: spi at 10600 {
 			status = "okay";
 
 			spi-flash at 0 {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 04f28a7..55bcbff 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -37,24 +37,24 @@
 	};
 
 	soc {
-		serial at d0012000 {
+		serial at 12000 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
-		serial at d0012100 {
+		serial at 12100 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
-		serial at d0012200 {
+		serial at 12200 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
-		serial at d0012300 {
+		serial at 12300 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
 
-		sata at d00a0000 {
+		sata at a0000 {
 			nr-ports = <2>;
 			status = "okay";
 		};
@@ -77,28 +77,28 @@
 			};
 		};
 
-		ethernet at d0070000 {
+		ethernet at 70000 {
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "rgmii-id";
 		};
-		ethernet at d0074000 {
+		ethernet at 74000 {
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
-		ethernet at d0030000 {
+		ethernet at 30000 {
 			status = "okay";
 			phy = <&phy2>;
 			phy-mode = "rgmii-id";
 		};
-		ethernet at d0034000 {
+		ethernet at 34000 {
 			status = "okay";
 			phy = <&phy3>;
 			phy-mode = "rgmii-id";
 		};
 
-		spi0: spi at d0010600 {
+		spi0: spi at 10600 {
 			status = "okay";
 
 			spi-flash at 0 {
@@ -110,7 +110,7 @@
 			};
 		};
 
-		devbus-bootcs at d0010400 {
+		devbus-bootcs at 10400 {
 			status = "okay";
 			ranges = <0 0xf0000000 0x1000000>; /* @addr 0xf000000, size 0x1000000 */
 
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index e072a53..12905ab 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -46,7 +46,7 @@
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78230-pinctrl";
-			reg = <0xd0018000 0x38>;
+			reg = <0x18000 0x38>;
 
 			sdio_pins: sdio-pins {
 				marvell,pins = "mpp30", "mpp31", "mpp32",
@@ -55,9 +55,9 @@
 			};
 		};
 
-		gpio0: gpio at d0018100 {
+		gpio0: gpio at 18100 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018100 0x40>;
+			reg = <0x18100 0x40>;
 			ngpios = <32>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -66,9 +66,9 @@
 			interrupts = <82>, <83>, <84>, <85>;
 		};
 
-		gpio1: gpio at d0018140 {
+		gpio1: gpio at 18140 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018140 0x40>;
+			reg = <0x18140 0x40>;
 			ngpios = <17>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -92,17 +92,17 @@
 
 			bus-range = <0x00 0xff>;
 
-			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
-				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
-				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
-				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
-				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
+			ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0x42000 0x42000 0 0x00002000   /* Port 2.0 registers */
+				  0x82000000 0 0x44000 0x44000 0 0x00002000   /* Port 0.1 registers */
+				  0x82000000 0 0x48000 0x48000 0 0x00002000   /* Port 0.2 registers */
+				  0x82000000 0 0x4c000 0x4c000 0 0x00002000   /* Port 0.3 registers */
 				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
 				  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
 
 			pcie at 1,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -118,7 +118,7 @@
 
 			pcie at 2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0044000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -134,7 +134,7 @@
 
 			pcie at 3,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0048000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -150,7 +150,7 @@
 
 			pcie at 4,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd004c000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -166,7 +166,7 @@
 
 			pcie at 9,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0042000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
 				reg = <0x4800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 6dae1bc..1faacd1 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -47,7 +47,7 @@
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78260-pinctrl";
-			reg = <0xd0018000 0x38>;
+			reg = <0x18000 0x38>;
 
 			sdio_pins: sdio-pins {
 				marvell,pins = "mpp30", "mpp31", "mpp32",
@@ -56,9 +56,9 @@
 			};
 		};
 
-		gpio0: gpio at d0018100 {
+		gpio0: gpio at 18100 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018100 0x40>;
+			reg = <0x18100 0x40>;
 			ngpios = <32>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -67,9 +67,9 @@
 			interrupts = <82>, <83>, <84>, <85>;
 		};
 
-		gpio1: gpio at d0018140 {
+		gpio1: gpio at 18140 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018140 0x40>;
+			reg = <0x18140 0x40>;
 			ngpios = <32>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -78,9 +78,9 @@
 			interrupts = <87>, <88>, <89>, <90>;
 		};
 
-		gpio2: gpio at d0018180 {
+		gpio2: gpio at 18180 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018180 0x40>;
+			reg = <0x18180 0x40>;
 			ngpios = <3>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -89,9 +89,9 @@
 			interrupts = <91>;
 		};
 
-		ethernet at d0034000 {
+		ethernet at 34000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0xd0034000 0x2500>;
+				reg = <0x34000 0x2500>;
 				interrupts = <14>;
 				clocks = <&gateclk 1>;
 				status = "disabled";
@@ -112,19 +112,19 @@
 
 			bus-range = <0x00 0xff>;
 
-			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
-				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
-				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
-				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
-				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
-				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000   /* Port 1.0 registers */
-				  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000   /* Port 3.0 registers */
+			ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0x42000 0x42000 0 0x00002000   /* Port 2.0 registers */
+				  0x82000000 0 0x44000 0x44000 0 0x00002000   /* Port 0.1 registers */
+				  0x82000000 0 0x48000 0x48000 0 0x00002000   /* Port 0.2 registers */
+				  0x82000000 0 0x4c000 0x4c000 0 0x00002000   /* Port 0.3 registers */
+				  0x82000000 0 0x80000 0x80000 0 0x00002000   /* Port 1.0 registers */
+				  0x82000000 0 0x82000 0x82000 0 0x00002000   /* Port 3.0 registers */
 				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
 				  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
 
 			pcie at 1,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -140,7 +140,7 @@
 
 			pcie at 2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0044000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -156,7 +156,7 @@
 
 			pcie at 3,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0048000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -172,7 +172,7 @@
 
 			pcie at 4,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd004c000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -188,7 +188,7 @@
 
 			pcie at 9,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0042000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
 				reg = <0x4800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -204,7 +204,7 @@
 
 			pcie at 10,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0082000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x82000 0 0x2000>;
 				reg = <0x5000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index b9da5b8..ce4f80a 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -62,7 +62,7 @@
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78460-pinctrl";
-			reg = <0xd0018000 0x38>;
+			reg = <0x18000 0x38>;
 
 			sdio_pins: sdio-pins {
 				marvell,pins = "mpp30", "mpp31", "mpp32",
@@ -71,9 +71,9 @@
 			};
 		};
 
-		gpio0: gpio at d0018100 {
+		gpio0: gpio at 18100 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018100 0x40>;
+			reg = <0x18100 0x40>;
 			ngpios = <32>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -82,9 +82,9 @@
 			interrupts = <82>, <83>, <84>, <85>;
 		};
 
-		gpio1: gpio at d0018140 {
+		gpio1: gpio at 18140 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018140 0x40>;
+			reg = <0x18140 0x40>;
 			ngpios = <32>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -93,9 +93,9 @@
 			interrupts = <87>, <88>, <89>, <90>;
 		};
 
-		gpio2: gpio at d0018180 {
+		gpio2: gpio at 18180 {
 			compatible = "marvell,orion-gpio";
-			reg = <0xd0018180 0x40>;
+			reg = <0x18180 0x40>;
 			ngpios = <3>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -104,9 +104,9 @@
 			interrupts = <91>;
 		};
 
-		ethernet at d0034000 {
+		ethernet at 34000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0xd0034000 0x2500>;
+				reg = <0x34000 0x2500>;
 				interrupts = <14>;
 				clocks = <&gateclk 1>;
 				status = "disabled";
@@ -127,22 +127,22 @@
 
 			bus-range = <0x00 0xff>;
 
-			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
-				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
-				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
-				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
-				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
-				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000   /* Port 1.0 registers */
-				  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000   /* Port 3.0 registers */
-				  0x82000000 0 0xd0084000 0xd0084000 0 0x00002000   /* Port 1.1 registers */
-				  0x82000000 0 0xd0088000 0xd0088000 0 0x00002000   /* Port 1.2 registers */
-				  0x82000000 0 0xd008c000 0xd008c000 0 0x00002000   /* Port 1.3 registers */
+			ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0x42000 0x42000 0 0x00002000   /* Port 2.0 registers */
+				  0x82000000 0 0x44000 0x44000 0 0x00002000   /* Port 0.1 registers */
+				  0x82000000 0 0x48000 0x48000 0 0x00002000   /* Port 0.2 registers */
+				  0x82000000 0 0x4c000 0x4c000 0 0x00002000   /* Port 0.3 registers */
+				  0x82000000 0 0x80000 0x80000 0 0x00002000   /* Port 1.0 registers */
+				  0x82000000 0 0x82000 0x82000 0 0x00002000   /* Port 3.0 registers */
+				  0x82000000 0 0x84000 0x84000 0 0x00002000   /* Port 1.1 registers */
+				  0x82000000 0 0x88000 0x88000 0 0x00002000   /* Port 1.2 registers */
+				  0x82000000 0 0x8c000 0x8c000 0 0x00002000   /* Port 1.3 registers */
 				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
 				  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
 
 			pcie at 1,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -158,7 +158,7 @@
 
 			pcie at 2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82001000 0 0xd0044000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -174,7 +174,7 @@
 
 			pcie at 3,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82001800 0 0xd0048000 0 0x2000>;
+				assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -190,7 +190,7 @@
 
 			pcie at 4,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82002000 0 0xd004c000 0 0x2000>;
+				assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -206,7 +206,7 @@
 
 			pcie at 5,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82002800 0 0xd0080000 0 0x2000>;
+				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 				reg = <0x2800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -222,7 +222,7 @@
 
 			pcie at 6,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82003000 0 0xd0084000 0 0x2000>;
+				assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
 				reg = <0x3000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -238,7 +238,7 @@
 
 			pcie at 7,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82003800 0 0xd0088000 0 0x2000>;
+				assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
 				reg = <0x3800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -254,7 +254,7 @@
 
 			pcie at 8,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82004000 0 0xd008c000 0 0x2000>;
+				assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
 				reg = <0x4000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -269,7 +269,7 @@
 			};
 			pcie at 9,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82004800 0 0xd0042000 0 0x2000>;
+				assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
 				reg = <0x4800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -285,7 +285,7 @@
 
 			pcie at 10,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82005000 0 0xd0082000 0 0x2000>;
+				assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
 				reg = <0x5000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 9d04f04..e9bc8bf 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,11 +27,11 @@
 	};
 
 	soc {
-		serial at d0012000 {
+		serial at 12000 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
-		serial at d0012100 {
+		serial at 12100 {
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
@@ -96,31 +96,31 @@
 			};
 		};
 
-		ethernet at d0070000 {
+		ethernet at 70000 {
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "sgmii";
 		};
-		ethernet at d0074000 {
+		ethernet at 74000 {
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "sgmii";
 		};
-		ethernet at d0030000 {
+		ethernet at 30000 {
 			status = "okay";
 			phy = <&phy2>;
 			phy-mode = "sgmii";
 		};
-		ethernet at d0034000 {
+		ethernet at 34000 {
 			status = "okay";
 			phy = <&phy3>;
 			phy-mode = "sgmii";
 		};
-		i2c at d0011000 {
+		i2c at 11000 {
 			status = "okay";
 			clock-frequency = <400000>;
 		};
-		i2c at d0011100 {
+		i2c at 11100 {
 			status = "okay";
 			clock-frequency = <400000>;
 
@@ -129,18 +129,18 @@
 				reg = <0x30>;
 			};
 		};
-		sata at d00a0000 {
+		sata at a0000 {
 			nr-ports = <2>;
 			status = "okay";
 		};
-		usb at d0050000 {
+		usb at 50000 {
 			status = "okay";
 		};
-		usb at d0051000 {
+		usb at 51000 {
 			status = "okay";
 		};
 
-		devbus-bootcs at d0010400 {
+		devbus-bootcs at 10400 {
 			status = "okay";
 			ranges = <0 0xf0000000 0x8000000>; /* @addr 0xf000000, size 0x8000000 */
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index ef3d413..465b9fa 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -22,83 +22,84 @@
 	model = "Marvell Armada XP family SoC";
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
+
 	soc {
 		L2: l2-cache {
 			compatible = "marvell,aurora-system-cache";
-			reg = <0xd0008000 0x1000>;
+			reg = <0x08000 0x1000>;
 			cache-id-part = <0x100>;
 			wt-override;
 		};
 
-		mpic: interrupt-controller at d0020000 {
-		      reg = <0xd0020a00 0x2d0>,
-			    <0xd0021070 0x58>;
+		mpic: interrupt-controller at 20000 {
+		      reg = <0x20a00 0x2d0>,
+			    <0x21070 0x58>;
 		};
 
-		armada-370-xp-pmsu at d0022000 {
+		armada-370-xp-pmsu at 22000 {
 			compatible = "marvell,armada-370-xp-pmsu";
-			reg = <0xd0022100 0x430>,
-			      <0xd0020800 0x20>;
+			reg = <0x22100 0x430>,
+			      <0x20800 0x20>;
 		};
 
-		serial at d0012200 {
+		serial at 12200 {
 				compatible = "snps,dw-apb-uart";
-				reg = <0xd0012200 0x100>;
+				reg = <0x12200 0x100>;
 				reg-shift = <2>;
 				interrupts = <43>;
 				reg-io-width = <1>;
 				status = "disabled";
 		};
-		serial at d0012300 {
+		serial at 12300 {
 				compatible = "snps,dw-apb-uart";
-				reg = <0xd0012300 0x100>;
+				reg = <0x12300 0x100>;
 				reg-shift = <2>;
 				interrupts = <44>;
 				reg-io-width = <1>;
 				status = "disabled";
 		};
 
-		timer at d0020300 {
+		timer at 20300 {
 				marvell,timer-25Mhz;
 		};
 
-		coreclk: mvebu-sar at d0018230 {
+		coreclk: mvebu-sar at 18230 {
 			compatible = "marvell,armada-xp-core-clock";
-			reg = <0xd0018230 0x08>;
+			reg = <0x18230 0x08>;
 			#clock-cells = <1>;
 		};
 
-		cpuclk: clock-complex at d0018700 {
+		cpuclk: clock-complex at 18700 {
 			#clock-cells = <1>;
 			compatible = "marvell,armada-xp-cpu-clock";
-			reg = <0xd0018700 0xA0>;
+			reg = <0x18700 0xA0>;
 			clocks = <&coreclk 1>;
 		};
 
-		gateclk: clock-gating-control at d0018220 {
+		gateclk: clock-gating-control at 18220 {
 			compatible = "marvell,armada-xp-gating-clock";
-			reg = <0xd0018220 0x4>;
+			reg = <0x18220 0x4>;
 			clocks = <&coreclk 0>;
 			#clock-cells = <1>;
 		};
 
-		system-controller at d0018200 {
+		system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0xd0018200 0x500>;
+				reg = <0x18200 0x500>;
 		};
 
-		ethernet at d0030000 {
+		ethernet at 30000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0xd0030000 0x2500>;
+				reg = <0x30000 0x2500>;
 				interrupts = <12>;
 				clocks = <&gateclk 2>;
 				status = "disabled";
 		};
 
-		xor at d0060900 {
+		xor at 60900 {
 			compatible = "marvell,orion-xor";
-			reg = <0xd0060900 0x100
-			       0xd0060b00 0x100>;
+			reg = <0x60900 0x100
+			       0x60b00 0x100>;
 			clocks = <&gateclk 22>;
 			status = "okay";
 
@@ -115,10 +116,10 @@
 			};
 		};
 
-		xor at d00f0900 {
+		xor at f0900 {
 			compatible = "marvell,orion-xor";
-			reg = <0xd00F0900 0x100
-			       0xd00F0B00 0x100>;
+			reg = <0xF0900 0x100
+			       0xF0B00 0x100>;
 			clocks = <&gateclk 28>;
 			status = "okay";
 
@@ -135,26 +136,26 @@
 			};
 		};
 
-		usb at d0050000 {
+		usb at 50000 {
 			clocks = <&gateclk 18>;
 		};
 
-		usb at d0051000 {
+		usb at 51000 {
 			clocks = <&gateclk 19>;
 		};
 
-		usb at d0052000 {
+		usb at 52000 {
 			compatible = "marvell,orion-ehci";
-			reg = <0xd0052000 0x500>;
+			reg = <0x52000 0x500>;
 			interrupts = <47>;
 			clocks = <&gateclk 20>;
 			status = "disabled";
 		};
 
-		thermal at d00182b0 {
+		thermal at 182b0 {
 			compatible = "marvell,armadaxp-thermal";
-			reg = <0xd00182b0 0x4
-			       0xd00184d0 0x4>;
+			reg = <0x182b0 0x4
+			       0x184d0 0x4>;
 			status = "okay";
 		};
 	};
-- 
1.7.9.5
