From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:43 +0200
Subject: [PATCH 40/48] ARM: dts: at91: sama5d2: TC blocks are also simple-mfd
 and syscon devices
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-41-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-mfd and syscon to the TC blocks to allow to register one of the
channels as clocksource properly at boot time. It also allows to use
regmap instead of tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2827e7ab5ebc..0db2f8b77227 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -906,7 +906,9 @@
 			};
 
 			tcb0: timer at f800c000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb0_clk>, <&clk32k>;
@@ -914,7 +916,9 @@
 			};
 
 			tcb1: timer at f8010000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xf8010000 0x100>;
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb1_clk>, <&clk32k>;
-- 
2.8.1
