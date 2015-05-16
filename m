From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:33 +0200
Subject: [PATCH 04/14] ARM: berlin: move reset to simple-mfd nodes
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

Now with a proper platform driver for reset and simple-mfd, move to
the new marvell,berlin-reset node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/berlin2.dtsi   |  6 +++++-
 arch/arm/boot/dts/berlin2cd.dtsi | 10 +++++++---
 arch/arm/boot/dts/berlin2q.dtsi  | 12 ++++++++----
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 245527abb77c..1e92511f8582 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -353,7 +353,6 @@
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
 			#clock-cells = <1>;
-			#reset-cells = <2>;
 			reg = <0xea0000 0x400>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
@@ -362,6 +361,11 @@
 				groups = "G26";
 				function = "emmc";
 			};
+
+			chip_rst: reset {
+				compatible = "marvell,berlin2-reset";
+				#reset-cells = <2>;
+			};
 		};
 
 		apb at fc0000 {
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index cccc23b45a26..5f8bfcdedceb 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -84,7 +84,7 @@
 			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xb74000 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x178 23>;
+			resets = <&chip_rst 0x178 23>;
 			status = "disabled";
 		};
 
@@ -92,7 +92,7 @@
 			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xb78000 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x178 24>;
+			resets = <&chip_rst 0x178 24>;
 			status = "disabled";
 		};
 
@@ -297,7 +297,6 @@
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2cd-chip-ctrl", "simple-mfd", "syscon";
 			#clock-cells = <1>;
-			#reset-cells = <2>;
 			reg = <0xea0000 0x400>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
@@ -306,6 +305,11 @@
 				groups = "G6";
 				function = "uart0";
 			};
+
+			chip_rst: reset {
+				compatible = "marvell,berlin2-reset";
+				#reset-cells = <2>;
+			};
 		};
 
 		usb0: usb at ed0000 {
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index a515b54bb3e5..a27d03a2b5fa 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -127,7 +127,7 @@
 			compatible = "marvell,berlin2-usb-phy";
 			reg = <0xa2f400 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x104 14>;
+			resets = <&chip_rst 0x104 14>;
 			status = "disabled";
 		};
 
@@ -145,7 +145,7 @@
 			compatible = "marvell,berlin2-usb-phy";
 			reg = <0xb74000 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x104 12>;
+			resets = <&chip_rst 0x104 12>;
 			status = "disabled";
 		};
 
@@ -153,7 +153,7 @@
 			compatible = "marvell,berlin2-usb-phy";
 			reg = <0xb78000 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x104 13>;
+			resets = <&chip_rst 0x104 13>;
 			status = "disabled";
 		};
 
@@ -362,7 +362,6 @@
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2q-chip-ctrl", "simple-mfd", "syscon";
 			#clock-cells = <1>;
-			#reset-cells = <2>;
 			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
@@ -376,6 +375,11 @@
 				groups = "G7";
 				function = "twsi1";
 			};
+
+			chip_rst: reset {
+				compatible = "marvell,berlin2-reset";
+				#reset-cells = <2>;
+			};
 		};
 
 		ahci: sata at e90000 {
-- 
2.1.0
