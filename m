From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 13:02:14 +0200
Subject: [PATCH 11/14] ARM: LPC32xx: DTS adjustment for using pl18x primecell
In-Reply-To: <1339412537-24485-1-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
Message-ID: <1339412537-24485-12-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adjusts the dts files to reference the pl18x primecell driver
correctly.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/boot/dts/lpc32xx.dtsi |    3 ++-
 arch/arm/boot/dts/phy3250.dts  |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
+++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
@@ -115,9 +115,10 @@
 			};
 
 			sd at 20098000 {
-				compatible = "arm,pl180", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				reg = <0x20098000 0x1000>;
 				interrupts = <0x0f 0>, <0x0d 0>;
+				status = "disable";
 			};
 
 			i2s1: i2s at 2009C000 {
--- linux-2.6.orig/arch/arm/boot/dts/phy3250.dts
+++ linux-2.6/arch/arm/boot/dts/phy3250.dts
@@ -129,6 +129,14 @@
 					compatible = "atmel,at25";
 				};
 			};
+
+			sd at 20098000 {
+				wp-gpios = <&gpio 3 0 0>;
+				cd-gpios = <&gpio 3 1 0>;
+				cd-inverted;
+				bus-width = <4>;
+				status = "okay";
+			};
 		};
 
 		fab {
