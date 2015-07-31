From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:42 +0200
Subject: [PATCH 06/23] ARM: at91/dt: at91sam9260: use slow clock where
 necessary
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the real-time timer, the shutdown
controller, the timer counters need the slow clock, add it where necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 4bc347549102..be9c027ddd97 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -359,11 +359,13 @@
 			rstc at fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			shdwc at fffffd10 {
 				compatible = "atmel,at91sam9260-shdwc";
 				reg = <0xfffffd10 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			pit: timer at fffffd30 {
@@ -379,8 +381,8 @@
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
 					      18 IRQ_TYPE_LEVEL_HIGH 0
 					      19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>;
-				clock-names = "t0_clk", "t1_clk", "t2_clk";
+				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>, <&clk32k>;
+				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
 			tcb1: timer at fffdc000 {
@@ -389,8 +391,8 @@
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0
 					      27 IRQ_TYPE_LEVEL_HIGH 0
 					      28 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc3_clk>, <&tc4_clk>, <&tc5_clk>;
-				clock-names = "t0_clk", "t1_clk", "t2_clk";
+				clocks = <&tc3_clk>, <&tc4_clk>, <&tc5_clk>, <&clk32k>;
+				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
 			pinctrl at fffff400 {
@@ -973,6 +975,7 @@
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-- 
2.1.4
