From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:21:59 +0200
Subject: [PATCH 13/20] ARM: at91/dt: sama5d4: use slow clock where necessary
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215726-27452-14-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the RTC and the shutdown
controller need the slow clock, add it where necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 arch/arm/boot/dts/sama5d4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 3ee22ee13c5a..d5bec50d14e0 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1279,11 +1279,13 @@
 			rstc at fc068600 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfc068600 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			shdwc at fc068610 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfc068610 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			pit: timer at fc068630 {
@@ -1296,6 +1298,7 @@
 			watchdog at fc068640 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfc068640 0x10>;
+				clocks = <&clk32k>;
 				status = "disabled";
 			};
 
@@ -1329,6 +1332,7 @@
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfc0686b0 0x30>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 			};
 
 			dbgu: serial at fc069000 {
-- 
2.1.4
