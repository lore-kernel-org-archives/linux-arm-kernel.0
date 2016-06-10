From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:37 +0200
Subject: [PATCH 34/48] ARM: dts: at91: sama5d4: TC blocks are also simple-mfd
 and syscon devices
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-35-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-mfd and syscon to the TC blocks to allow to register one of the
channels as clocksource properly at boot time. It also allow sto reuse
regmap instead of tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 4e2cc30d6615..9fd39a0d2251 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -954,7 +954,9 @@
 			};
 
 			tcb0: timer at f801c000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xf801c000 0x100>;
 				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb0_clk>, <&clk32k>;
@@ -1182,7 +1184,9 @@
 			};
 
 			tcb1: timer at fc020000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xfc020000 0x100>;
 				interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb1_clk>, <&clk32k>;
-- 
2.8.1
