From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:44 +0200
Subject: [PATCH 08/23] ARM: at91/dt: at91sam9263: use slow clock where
 necessary
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the two real-time timers, the shutdown
controller and the timer counter need the slow clock, add it where
necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index e36d966ef5e8..f1f5fa3a9e6e 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -377,18 +377,20 @@
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfff7c000 0x100>;
 				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb_clk>;
-				clock-names = "t0_clk";
+				clocks = <&tcb_clk>, <&slow_xtal>;
+				clock-names = "t0_clk", "slow_clk";
 			};
 
 			rstc at fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
+				clocks = <&slow_xtal>;
 			};
 
 			shdwc at fffffd10 {
 				compatible = "atmel,at91sam9260-shdwc";
 				reg = <0xfffffd10 0x10>;
+				clocks = <&slow_xtal>;
 			};
 
 			pinctrl at fffff200 {
@@ -902,6 +904,7 @@
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&slow_xtal>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-- 
2.1.4
