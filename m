From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:41 +0200
Subject: [PATCH 05/23] ARM: at91/dt: at91rm9200: use slow clock where necessary
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system timer, the RTC and the timer counters need the slow clock, add
it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index e3cfb9972f54..60edd8baebb8 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -359,6 +359,7 @@
 				compatible = "atmel,at91rm9200-st", "syscon", "simple-mfd";
 				reg = <0xfffffd00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&slow_xtal>;
 
 				watchdog {
 					compatible = "atmel,at91rm9200-wdt";
@@ -369,6 +370,7 @@
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffe00 0x40>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&slow_xtal>;
 				status = "disabled";
 			};
 
@@ -378,8 +380,8 @@
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
 					      18 IRQ_TYPE_LEVEL_HIGH 0
 					      19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>;
-				clock-names = "t0_clk", "t1_clk", "t2_clk";
+				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>, <&slow_xtal>;
+				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
 			tcb1: timer at fffa4000 {
@@ -388,8 +390,8 @@
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0
 					      21 IRQ_TYPE_LEVEL_HIGH 0
 					      22 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc3_clk>, <&tc4_clk>, <&tc5_clk>;
-				clock-names = "t0_clk", "t1_clk", "t2_clk";
+				clocks = <&tc3_clk>, <&tc4_clk>, <&tc5_clk>, <&slow_xtal>;
+				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
 			i2c0: i2c at fffb8000 {
-- 
2.1.4
