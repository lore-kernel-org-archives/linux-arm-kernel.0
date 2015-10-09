From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 10 Oct 2015 00:10:39 +0200
Subject: [PATCH 2/2] arm: mvebu: reorder nodes under internal-regs by address
 in RN2120 .dts file
In-Reply-To: <cover.1444428035.git.arno@natisbad.org>
References: <cover.1444428035.git.arno@natisbad.org>
Message-ID: <277de75473af2431849a7494ae65b57dbc9a8309.1444428035.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This cosmetic patch reorder nodes under internal-regs by increasing
address order, as epxected.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 86 +++++++++++++-------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 85b2f87c0b8a..d72a69d97ba2 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -94,54 +94,11 @@
 				status = "disabled";
 			};
 
-			/* Two rear eSATA ports */
-			sata at a0000 {
-				nr-ports = <2>;
-				status = "okay";
-			};
-
-			serial at 12000 {
-				status = "okay";
-			};
-
-			mdio {
-				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
-					reg = <1>;
-				};
-			};
-
-			ethernet at 70000 {
-				status = "okay";
-				phy = <&phy0>;
-				phy-mode = "rgmii-id";
-			};
-
-			ethernet at 74000 {
-				status = "okay";
-				phy = <&phy1>;
-				phy-mode = "rgmii-id";
-			};
-
-			/* Front USB 2.0 port */
-			usb at 50000 {
-				status = "okay";
-			};
-
 			i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
 				clock-frequency = <400000>;
 				status = "okay";
 
-				isl12057: isl12057 at 68 {
-					compatible = "isil,isl12057";
-					reg = <0x68>;
-					isil,irq2-can-wakeup-machine;
-				};
-
 				/* Controller for rear fan #1 of 3 (Protechnic
 				 * MGT4012XB-O20, 8000RPM) near eSATA port */
 				g762_fan1: g762 at 3e {
@@ -178,6 +135,49 @@
 					compatible = "gmt,g751";
 					reg = <0x4c>;
 				};
+
+				isl12057: isl12057 at 68 {
+					compatible = "isil,isl12057";
+					reg = <0x68>;
+					isil,irq2-can-wakeup-machine;
+				};
+			};
+
+			serial at 12000 {
+				status = "okay";
+			};
+
+			/* Front USB 2.0 port */
+			usb at 50000 {
+				status = "okay";
+			};
+
+			mdio {
+				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
+					reg = <0>;
+				};
+
+				phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
+					reg = <1>;
+				};
+			};
+
+			ethernet at 70000 {
+				status = "okay";
+				phy = <&phy0>;
+				phy-mode = "rgmii-id";
+			};
+
+			ethernet at 74000 {
+				status = "okay";
+				phy = <&phy1>;
+				phy-mode = "rgmii-id";
+			};
+
+			/* Two rear eSATA ports */
+			sata at a0000 {
+				nr-ports = <2>;
+				status = "okay";
 			};
 
 			nand at d0000 {
-- 
2.5.3
