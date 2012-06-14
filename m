From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:03 +0200
Subject: [PATCH v2 13/23] ARM: LPC32xx: High Speed UART configuration via DT
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-14-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the DTS files for the High Speed UARTs 1, 2 and 7 of the
LPC32xx SoC, adjusting the compatible strings, adding interrupts and status
configuration. On the PHY3250 reference board, UART2 is enabled.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/boot/dts/lpc32xx.dtsi |   16 +++++++++++-----
 arch/arm/boot/dts/phy3250.dts  |    4 ++++
 2 files changed, 15 insertions(+), 5 deletions(-)

--- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
+++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
@@ -212,18 +212,24 @@
 			};
 
 			uart1: serial at 40014000 {
-				compatible = "nxp,serial";
+				compatible = "nxp,lpc3220-hsuart";
 				reg = <0x40014000 0x1000>;
+				interrupts = <26 0>;
+				status = "disabled";
 			};
 
 			uart2: serial at 40018000 {
-				compatible = "nxp,serial";
+				compatible = "nxp,lpc3220-hsuart";
 				reg = <0x40018000 0x1000>;
+				interrupts = <25 0>;
+				status = "disabled";
 			};
 
-			uart7: serial at 4001C000 {
-				compatible = "nxp,serial";
-				reg = <0x4001C000 0x1000>;
+			uart7: serial at 4001c000 {
+				compatible = "nxp,lpc3220-hsuart";
+				reg = <0x4001c000 0x1000>;
+				interrupts = <24 0>;
+				status = "disabled";
 			};
 
 			rtc at 40024000 {
--- linux-2.6.orig/arch/arm/boot/dts/phy3250.dts
+++ linux-2.6/arch/arm/boot/dts/phy3250.dts
@@ -148,6 +148,10 @@
 		};
 
 		fab {
+			uart2: serial at 40018000 {
+				status = "okay";
+			};
+
 			tsc at 40048000 {
 				status = "okay";
 			};
