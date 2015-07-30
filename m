From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:21:54 +0200
Subject: [PATCH 08/20] ARM: at91/dt: at91sam9g45: use slow clock where
 necessary
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215726-27452-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the RTC, the real-time timer and the
shutdown controller need the slow clock, add it where necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 arch/arm/boot/dts/at91sam9g45.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 18177f5a7464..74e54fb08898 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -387,6 +387,7 @@
 			rstc at fffffd00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffd00 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			pit: timer at fffffd30 {
@@ -400,6 +401,7 @@
 			shdwc at fffffd10 {
 				compatible = "atmel,at91sam9rl-shdwc";
 				reg = <0xfffffd10 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			tcb0: timer at fff7c000 {
@@ -1113,6 +1115,7 @@
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1247,6 +1250,7 @@
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffdb0 0x30>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				status = "disabled";
 			};
 
-- 
2.1.4
