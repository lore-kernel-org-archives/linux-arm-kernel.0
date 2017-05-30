From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:05 +0200
Subject: [PATCH 24/58] ARM: dts: at91: at91sam9n12: TC blocks are also
 simple-mfd and syscon devices
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-25-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-mfd and syscon to the TC blocks to allow to register one of the
channels as clocksource properly at boot time. It also allows to use regmap
instead of tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index f43d7695352d..d86f35fecdb8 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -430,7 +430,9 @@
 			};
 
 			tcb0: timer at f8008000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xf8008000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb_clk>, <&clk32k>;
@@ -438,7 +440,9 @@
 			};
 
 			tcb1: timer at f800c000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb_clk>, <&clk32k>;
-- 
2.11.0
