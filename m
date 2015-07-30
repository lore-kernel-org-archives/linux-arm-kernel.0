From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:21:51 +0200
Subject: [PATCH 05/20] ARM: at91/dt: at91sam9260: use slow clock where
 necessary
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215726-27452-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the real-time timer and the shutdown
controller need the slow clock, add it where necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 arch/arm/boot/dts/at91sam9260.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 4bc347549102..03c1b43cb3ee 100644
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
