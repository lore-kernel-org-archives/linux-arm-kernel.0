From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:47 +0200
Subject: [PATCH 11/23] ARM: at91/dt: at91sam9rl: use slow clock where necessary
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-12-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the RTC, the real-time timer, the
shutdown controller and the timer counter need the slow clock, add it where
necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rl.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index c9920c64791c..a0b90aedd3b8 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -121,8 +121,8 @@
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 0>,
 					     <17 IRQ_TYPE_LEVEL_HIGH 0>,
 					     <18 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>;
-				clock-names = "t0_clk", "t1_clk", "t2_clk";
+				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>, <&clk32k>;
+				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
 			mmc0: mmc at fffa4000 {
@@ -1018,11 +1018,13 @@
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
@@ -1036,6 +1038,7 @@
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				status = "disabled";
 			};
 
@@ -1083,6 +1086,7 @@
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffe00 0x40>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				status = "disabled";
 			};
 
-- 
2.1.4
