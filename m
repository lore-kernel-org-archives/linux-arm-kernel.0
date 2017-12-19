From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:43 +0100
Subject: [PATCH 19/45] ARM: dts: at91: at91sam9g45: TC blocks are also
 simple-mfd and syscon devices
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-20-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-mfd and syscon to the TC blocks to allow to register one of the
channels as clocksource properly at boot time and free up the remaining
channels for other use.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2b127ca7aaa0..ce204b4a5dee 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -415,7 +415,9 @@
 			};
 
 			tcb0: timer at fff7c000 {
-				compatible = "atmel,at91rm9200-tcb";
+				compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xfff7c000 0x100>;
 				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb0_clk>, <&tcb0_clk>, <&tcb0_clk>, <&clk32k>;
@@ -423,7 +425,9 @@
 			};
 
 			tcb1: timer at fffd4000 {
-				compatible = "atmel,at91rm9200-tcb";
+				compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xfffd4000 0x100>;
 				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb0_clk>, <&tcb0_clk>, <&tcb0_clk>, <&clk32k>;
-- 
2.15.1
