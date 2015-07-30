From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:21:57 +0200
Subject: [PATCH 11/20] ARM: at91/dt: at91sam9x5: use slow clock where necessary
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215726-27452-12-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the RTC and the shutdown controller
need the slow clock, add it where necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 arch/arm/boot/dts/at91sam9x5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index b6c8df8d380e..2d8c9f5caff9 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -376,11 +376,13 @@
 			rstc at fffffe00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			shdwc at fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			pit: timer at fffffe30 {
@@ -1173,6 +1175,7 @@
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1183,6 +1186,7 @@
 				compatible = "atmel,at91sam9x5-rtc";
 				reg = <0xfffffeb0 0x40>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				status = "disabled";
 			};
 
-- 
2.1.4
