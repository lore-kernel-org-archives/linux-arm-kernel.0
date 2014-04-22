From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:18 +0200
Subject: [PATCH v2 14/38] ARM: orion5x: add node labels in Orion5x SoC Device
 Tree file
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to ease identification of devices, it is useful to have
Device Tree labels on all devices. This commit adds such labels to the
Orion5x SoC Device Tree file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/orion5x.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 31d46e6..aef5d17 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -41,7 +41,7 @@
 				interrupts = <6>, <7>, <8>, <9>;
 			};
 
-			spi at 10600 {
+			spi: spi at 10600 {
 				compatible = "marvell,orion-spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -50,7 +50,7 @@
 				status = "disabled";
 			};
 
-			i2c at 11000 {
+			i2c: i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
 				reg = <0x11000 0x20>;
 				#address-cells = <1>;
@@ -60,7 +60,7 @@
 				status = "disabled";
 			};
 
-			serial at 12000 {
+			uart0: serial at 12000 {
 				compatible = "ns16550a";
 				reg = <0x12000 0x100>;
 				reg-shift = <2>;
@@ -69,7 +69,7 @@
 				status = "disabled";
 			};
 
-			serial at 12100 {
+			uart1: serial at 12100 {
 				compatible = "ns16550a";
 				reg = <0x12100 0x100>;
 				reg-shift = <2>;
@@ -85,20 +85,20 @@
 				reg = <0x20200 0x08>;
 			};
 
-			wdt at 20300 {
+			wdt: wdt at 20300 {
 				compatible = "marvell,orion-wdt";
 				reg = <0x20300 0x28>;
 				status = "okay";
 			};
 
-			ehci at 50000 {
+			ehci0: ehci at 50000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x50000 0x1000>;
 				interrupts = <17>;
 				status = "disabled";
 			};
 
-			xor at 60900 {
+			xor: xor at 60900 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60900 0x100
 				       0x60b00 0x100>;
@@ -125,7 +125,7 @@
 				marvell,tx-checksum-limit = <1600>;
 				status = "disabled";
 
-				ethernet-port at 0 {
+				ethport: ethernet-port at 0 {
 					compatible = "marvell,orion-eth-port";
 					reg = <0>;
 					/* overwrite MAC address in bootloader */
@@ -145,14 +145,14 @@
 				/* add phy nodes in board file */
 			};
 
-			sata at 80000 {
+			sata: sata at 80000 {
 				compatible = "marvell,orion-sata";
 				reg = <0x80000 0x5000>;
 				interrupts = <29>;
 				status = "disabled";
 			};
 
-			ehci at a0000 {
+			ehci1: ehci at a0000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0xa0000 0x1000>;
 				interrupts = <12>;
@@ -160,7 +160,7 @@
 			};
 		};
 
-		crypto at 90000 {
+		cesa: crypto at 90000 {
 			compatible = "marvell,orion-crypto";
 			reg = <MBUS_ID(0xf0, 0x01) 0x90000 0x10000>,
 			      <MBUS_ID(0x09, 0x00) 0x0 0x800>;
-- 
1.9.2
