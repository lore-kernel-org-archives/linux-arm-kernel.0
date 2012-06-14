From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:05 +0200
Subject: [PATCH v2 15/23] ARM: LPC32xx: Fix lpc32xx.dtsi status property:
 "disable" -> "disabled"
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-16-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches fixes some status = "disable" strings to "disabled", the correct
way of disabling nodes in the devicetree.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/boot/dts/lpc32xx.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
+++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
@@ -35,14 +35,14 @@
 		slc: flash at 20020000 {
 			compatible = "nxp,lpc3220-slc";
 			reg = <0x20020000 0x1000>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		mlc: flash at 200a8000 {
 			compatible = "nxp,lpc3220-mlc";
 			reg = <0x200a8000 0x11000>;
 			interrupts = <11 0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		dma at 31000000 {
@@ -58,21 +58,21 @@
 			compatible = "nxp,ohci-nxp", "usb-ohci";
 			reg = <0x31020000 0x300>;
 			interrupts = <0x3b 0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		usbd at 31020000 {
 			compatible = "nxp,lpc3220-udc";
 			reg = <0x31020000 0x300>;
 			interrupts = <0x3d 0>, <0x3e 0>, <0x3c 0>, <0x3a 0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		clcd at 31040000 {
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0x31040000 0x1000>;
 			interrupts = <0x0e 0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		mac: ethernet at 31060000 {
@@ -261,14 +261,14 @@
 				compatible = "nxp,lpc3220-adc";
 				reg = <0x40048000 0x1000>;
 				interrupts = <0x27 0>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			tsc at 40048000 {
 				compatible = "nxp,lpc3220-tsc";
 				reg = <0x40048000 0x1000>;
 				interrupts = <0x27 0>;
-				status = "disable";
+				status = "disabled";
 			};
 
 			key at 40050000 {
