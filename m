From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:52 +0100
Subject: [PATCH v3 03/19] ARM: dts: armada-370-xp: add node labels
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it was previously done for kirkwood, this adds missing node labels to
Armada 370 and XP common and SoC specific nodes to allow to reference
them more easily.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi     | 32 ++++++++++++++++----------------
 arch/arm/boot/dts/armada-370.dtsi        | 20 ++++++++++----------
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 12 ++++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 20 ++++++++++----------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 22 +++++++++++-----------
 arch/arm/boot/dts/armada-xp.dtsi         | 12 ++++++------
 6 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 1d8171380fa0..54359896b76c 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -86,7 +86,7 @@
 		pcie-mem-aperture = <0xf8000000 0x7e00000>;
 		pcie-io-aperture  = <0xffe00000 0x100000>;
 
-		devbus-bootcs {
+		devbus_bootcs: devbus-bootcs {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10400 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0xffffffff>;
@@ -96,7 +96,7 @@
 			status = "disabled";
 		};
 
-		devbus-cs0 {
+		devbus_cs0: devbus-cs0 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10408 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3e) 0 0xffffffff>;
@@ -106,7 +106,7 @@
 			status = "disabled";
 		};
 
-		devbus-cs1 {
+		devbus_cs1: devbus-cs1 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10410 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3d) 0 0xffffffff>;
@@ -116,7 +116,7 @@
 			status = "disabled";
 		};
 
-		devbus-cs2 {
+		devbus_cs2: devbus-cs2 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10418 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3b) 0 0xffffffff>;
@@ -126,7 +126,7 @@
 			status = "disabled";
 		};
 
-		devbus-cs3 {
+		devbus_cs3: devbus-cs3 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10420 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x37) 0 0xffffffff>;
@@ -142,7 +142,7 @@
 			#size-cells = <1>;
 			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
 
-			rtc at 10300 {
+			rtc: rtc at 10300 {
 				compatible = "marvell,orion-rtc";
 				reg = <0x10300 0x20>;
 				interrupts = <50>;
@@ -214,38 +214,38 @@
 				msi-controller;
 			};
 
-			coherency-fabric at 20200 {
+			coherencyfab: coherency-fabric at 20200 {
 				compatible = "marvell,coherency-fabric";
 				reg = <0x20200 0xb0>, <0x21010 0x1c>;
 			};
 
-			timer at 20300 {
+			timer: timer at 20300 {
 				reg = <0x20300 0x30>, <0x21040 0x30>;
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			};
 
-			watchdog at 20300 {
+			watchdog: watchdog at 20300 {
 				reg = <0x20300 0x34>, <0x20704 0x4>;
 			};
 
-			cpurst at 20800 {
+			cpurst: cpurst at 20800 {
 				compatible = "marvell,armada-370-cpu-reset";
 				reg = <0x20800 0x8>;
 			};
 
-			pmsu at 22000 {
+			pmsu: pmsu at 22000 {
 				compatible = "marvell,armada-370-pmsu";
 				reg = <0x22000 0x1000>;
 			};
 
-			usb at 50000 {
+			usb0: usb at 50000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x50000 0x500>;
 				interrupts = <45>;
 				status = "disabled";
 			};
 
-			usb at 51000 {
+			usb1: usb at 51000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x51000 0x500>;
 				interrupts = <46>;
@@ -274,7 +274,7 @@
 				status = "disabled";
 			};
 
-			sata at a0000 {
+			sata: sata at a0000 {
 				compatible = "marvell,armada-370-sata";
 				reg = <0xa0000 0x5000>;
 				interrupts = <55>;
@@ -283,7 +283,7 @@
 				status = "disabled";
 			};
 
-			nand at d0000 {
+			nand: nand at d0000 {
 				compatible = "marvell,armada370-nand";
 				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
@@ -293,7 +293,7 @@
 				status = "disabled";
 			};
 
-			mvsdio at d4000 {
+			sdio: mvsdio at d4000 {
 				compatible = "marvell,orion-sdio";
 				reg = <0xd4000 0x200>;
 				interrupts = <54>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 79b5463209aa..5ed086da1e51 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -70,7 +70,7 @@
 			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
 		};
 
-		pcie-controller {
+		pciec: pcie-controller {
 			compatible = "marvell,armada-370-pcie";
 			status = "disabled";
 			device_type = "pci";
@@ -89,7 +89,7 @@
 				0x82000000 0x2 0     MBUS_ID(0x08, 0xe8) 0       1 0 /* Port 1.0 MEM */
 				0x81000000 0x2 0     MBUS_ID(0x08, 0xe0) 0       1 0 /* Port 1.0 IO  */>;
 
-			pcie at 1,0 {
+			pcie0: pcie at 1,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
@@ -106,7 +106,7 @@
 				status = "disabled";
 			};
 
-			pcie at 2,0 {
+			pcie2: pcie at 2,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
@@ -190,7 +190,7 @@
 				pinctrl-names = "default";
 			};
 
-			system-controller at 18200 {
+			systemc: system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0x18200 0x100>;
 			};
@@ -208,14 +208,14 @@
 				#clock-cells = <1>;
 			};
 
-			thermal at 18300 {
+			thermal: thermal at 18300 {
 				compatible = "marvell,armada370-thermal";
 				reg = <0x18300 0x4
 					0x18304 0x4>;
 				status = "okay";
 			};
 
-			sscg at 18330 {
+			sscg: sscg at 18330 {
 				reg = <0x18330 0x4>;
 			};
 
@@ -233,7 +233,7 @@
 				clocks = <&coreclk 2>;
 			};
 
-			cpu-config at 21000 {
+			cpuconf: cpu-config at 21000 {
 				compatible = "marvell,armada-370-cpu-config";
 				reg = <0x21000 0x8>;
 			};
@@ -256,7 +256,7 @@
 				clocks = <&coreclk 0>;
 			};
 
-			xor at 60800 {
+			xor0: xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
 				       0x60A00 0x100>;
@@ -275,7 +275,7 @@
 				};
 			};
 
-			xor at 60900 {
+			xor1: xor at 60900 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60900 0x100
 				       0x60b00 0x100>;
@@ -302,7 +302,7 @@
 				compatible = "marvell,armada-370-neta";
 			};
 
-			crypto at 90000 {
+			cesa: crypto at 90000 {
 				compatible = "marvell,armada-370-crypto";
 				reg = <0x90000 0x10000>;
 				reg-names = "regs";
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 6e6d0f04bf2b..ebf79d6de1a1 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -86,7 +86,7 @@
 		 * configured as x4 or quad x1 lanes. One unit is
 		 * x1 only.
 		 */
-		pcie-controller {
+		pciec: pcie-controller {
 			compatible = "marvell,armada-xp-pcie";
 			status = "disabled";
 			device_type = "pci";
@@ -114,7 +114,7 @@
 				0x82000000 0x5 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
 				0x81000000 0x5 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */>;
 
-			pcie at 1,0 {
+			pcie1: pcie at 1,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
@@ -131,7 +131,7 @@
 				status = "disabled";
 			};
 
-			pcie at 2,0 {
+			pcie2: pcie at 2,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
@@ -148,7 +148,7 @@
 				status = "disabled";
 			};
 
-			pcie at 3,0 {
+			pcie3: pcie at 3,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
@@ -165,7 +165,7 @@
 				status = "disabled";
 			};
 
-			pcie at 4,0 {
+			pcie4: pcie at 4,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
@@ -182,7 +182,7 @@
 				status = "disabled";
 			};
 
-			pcie at 5,0 {
+			pcie5: pcie at 5,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
 				reg = <0x2800 0 0 0 0>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index c5fdc99f0dbe..34e78a568460 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -87,7 +87,7 @@
 		 * configured as x4 or quad x1 lanes. One unit is
 		 * x4 only.
 		 */
-		pcie-controller {
+		pciec: pcie-controller {
 			compatible = "marvell,armada-xp-pcie";
 			status = "disabled";
 			device_type = "pci";
@@ -129,7 +129,7 @@
 				0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
 				0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */>;
 
-			pcie at 1,0 {
+			pcie1: pcie at 1,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
@@ -146,7 +146,7 @@
 				status = "disabled";
 			};
 
-			pcie at 2,0 {
+			pcie2: pcie at 2,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
@@ -163,7 +163,7 @@
 				status = "disabled";
 			};
 
-			pcie at 3,0 {
+			pcie3: pcie at 3,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
@@ -180,7 +180,7 @@
 				status = "disabled";
 			};
 
-			pcie at 4,0 {
+			pcie4: pcie at 4,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
@@ -197,7 +197,7 @@
 				status = "disabled";
 			};
 
-			pcie at 5,0 {
+			pcie5: pcie at 5,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
 				reg = <0x2800 0 0 0 0>;
@@ -214,7 +214,7 @@
 				status = "disabled";
 			};
 
-			pcie at 6,0 {
+			pcie6: pcie at 6,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x84000 0 0x2000>;
 				reg = <0x3000 0 0 0 0>;
@@ -231,7 +231,7 @@
 				status = "disabled";
 			};
 
-			pcie at 7,0 {
+			pcie7: pcie at 7,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x88000 0 0x2000>;
 				reg = <0x3800 0 0 0 0>;
@@ -248,7 +248,7 @@
 				status = "disabled";
 			};
 
-			pcie at 8,0 {
+			pcie8: pcie at 8,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x8c000 0 0x2000>;
 				reg = <0x4000 0 0 0 0>;
@@ -265,7 +265,7 @@
 				status = "disabled";
 			};
 
-			pcie at 9,0 {
+			pcie9: pcie at 9,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
 				reg = <0x4800 0 0 0 0>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 0e24f1a38540..5148827ed934 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -104,7 +104,7 @@
 		 * configured as x4 or quad x1 lanes. Two units are
 		 * x4/x1.
 		 */
-		pcie-controller {
+		pciec: pcie-controller {
 			compatible = "marvell,armada-xp-pcie";
 			status = "disabled";
 			device_type = "pci";
@@ -150,7 +150,7 @@
 				0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
 				0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
 
-			pcie at 1,0 {
+			pcie1: pcie at 1,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 				reg = <0x0800 0 0 0 0>;
@@ -167,7 +167,7 @@
 				status = "disabled";
 			};
 
-			pcie at 2,0 {
+			pcie2: pcie at 2,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
@@ -184,7 +184,7 @@
 				status = "disabled";
 			};
 
-			pcie at 3,0 {
+			pcie3: pcie at 3,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
@@ -201,7 +201,7 @@
 				status = "disabled";
 			};
 
-			pcie at 4,0 {
+			pcie4: pcie at 4,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
@@ -218,7 +218,7 @@
 				status = "disabled";
 			};
 
-			pcie at 5,0 {
+			pcie5: pcie at 5,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 				reg = <0x2800 0 0 0 0>;
@@ -235,7 +235,7 @@
 				status = "disabled";
 			};
 
-			pcie at 6,0 {
+			pcie6: pcie at 6,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
 				reg = <0x3000 0 0 0 0>;
@@ -252,7 +252,7 @@
 				status = "disabled";
 			};
 
-			pcie at 7,0 {
+			pcie7: pcie at 7,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
 				reg = <0x3800 0 0 0 0>;
@@ -269,7 +269,7 @@
 				status = "disabled";
 			};
 
-			pcie at 8,0 {
+			pcie8: pcie at 8,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
 				reg = <0x4000 0 0 0 0>;
@@ -286,7 +286,7 @@
 				status = "disabled";
 			};
 
-			pcie at 9,0 {
+			pcie9: pcie at 9,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
 				reg = <0x4800 0 0 0 0>;
@@ -303,7 +303,7 @@
 				status = "disabled";
 			};
 
-			pcie at 10,0 {
+			pcie10: pcie at 10,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
 				reg = <0x5000 0 0 0 0>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index e141de2a4a1c..654a61e525b4 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -118,7 +118,7 @@
 				status = "disabled";
 			};
 
-			system-controller at 18200 {
+			systemc: system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0x18200 0x500>;
 			};
@@ -136,7 +136,7 @@
 				#clock-cells = <1>;
 			};
 
-			thermal at 182b0 {
+			thermal: thermal at 182b0 {
 				compatible = "marvell,armadaxp-thermal";
 				reg = <0x182b0 0x4
 					0x184d0 0x4>;
@@ -191,7 +191,7 @@
 				clocks = <&gateclk 19>;
 			};
 
-			usb at 52000 {
+			usb2: usb at 52000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x52000 0x500>;
 				interrupts = <47>;
@@ -199,7 +199,7 @@
 				status = "disabled";
 			};
 
-			xor at 60900 {
+			xor1: xor at 60900 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60900 0x100
 				       0x60b00 0x100>;
@@ -227,7 +227,7 @@
 				compatible = "marvell,armada-xp-neta";
 			};
 
-			crypto at 90000 {
+			cesa: crypto at 90000 {
 				compatible = "marvell,armada-xp-crypto";
 				reg = <0x90000 0x10000>;
 				reg-names = "regs";
@@ -247,7 +247,7 @@
 				status = "disabled";
 			};
 
-			xor at f0900 {
+			xor0: xor at f0900 {
 				compatible = "marvell,orion-xor";
 				reg = <0xF0900 0x100
 				       0xF0B00 0x100>;
-- 
2.10.2
