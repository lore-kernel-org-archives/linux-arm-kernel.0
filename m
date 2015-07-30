From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:21:50 +0200
Subject: [PATCH 04/20] ARM: at91/dt: at91rm9200: use slow clock where necessary
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215726-27452-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system timer and the RTC need the slow clock, add it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 arch/arm/boot/dts/at91rm9200.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index e3cfb9972f54..385e0c36dece 100644
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
 
-- 
2.1.4
