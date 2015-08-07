From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  7 Aug 2015 12:57:20 +0200
Subject: [PATCH] ARM: at91: dt: sama5d2: use slow clock where necessary
Message-ID: <1438945040-11800-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the RTC, the shutdown controller, the
timer counters and the LCD PWM need the slow clock, add it to the currently
defined nodes.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index f39258fa3815..034cd48ae28b 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -764,16 +764,16 @@
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf800c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>;
-				clock-names = "t0_clk";
+				clocks = <&tcb0_clk>, <&clk32k>;
+				clock-names = "t0_clk", "slow_clk";
 			};
 
 			tcb1: timer at f8010000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8010000 0x100>;
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb1_clk>;
-				clock-names = "t0_clk";
+				clocks = <&tcb1_clk>, <&clk32k>;
+				clock-names = "t0_clk", "slow_clk";
 			};
 
 			uart0: serial at f801c000 {
@@ -857,6 +857,7 @@
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xf80480b0 0x30>;
 				interrupts = <74 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 			};
 
 			spi1: spi at fc000000 {
-- 
2.1.4
