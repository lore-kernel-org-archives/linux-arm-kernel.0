From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:40 +0100
Subject: [PATCH 16/45] ARM: dts: at91: at91sam9263: TC blocks are also
 simple-mfd and syscon devices
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-17-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-mfd and syscon to the TC blocks to allow to register one of the
channels as clocksource properly at boot time and free up the remaining
channels for other use.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index e54f14d36b6f..9e401fb980b5 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -389,7 +389,9 @@
 			};
 
 			tcb0: timer at fff7c000 {
-				compatible = "atmel,at91rm9200-tcb";
+				compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xfff7c000 0x100>;
 				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb_clk>, <&slow_xtal>;
-- 
2.15.1
