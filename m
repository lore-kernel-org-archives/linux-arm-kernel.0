From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:50 +0200
Subject: [PATCH 14/23] ARM: at91/dt: sama5d4: use slow clock where necessary
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-15-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the RTC, the shutdown controller, the
timer counters and the LCD PWM need the slow clock, add it where necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 3ee22ee13c5a..1d3abf2605e9 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -957,8 +957,8 @@
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf801c000 0x100>;
 				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>;
-				clock-names = "t0_clk";
+				clocks = <&tcb0_clk>, <&clk32k>;
+				clock-names = "t0_clk", "slow_clk";
 			};
 
 			macb0: ethernet at f8020000 {
@@ -1185,8 +1185,8 @@
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xfc020000 0x100>;
 				interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb1_clk>;
-				clock-names = "t0_clk";
+				clocks = <&tcb1_clk>, <&clk32k>;
+				clock-names = "t0_clk", "slow_clk";
 			};
 
 			adc0: adc at fc034000 {
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
