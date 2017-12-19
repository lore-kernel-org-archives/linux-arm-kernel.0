From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:32:02 +0100
Subject: [PATCH 38/45] ARM: dts: at91: sama5d4: Add TCB2
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-39-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third TC block is missing from the dtsi. It has no output pins but can
still be used for timers as the IRQ is wired.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 652c047753f0..373b3621b536 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1199,6 +1199,16 @@
 				clock-names = "t0_clk", "slow_clk";
 			};
 
+			tcb2: timer at fc024000 {
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0xfc024000 0x100>;
+				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&tcb2_clk>, <&clk32k>;
+				clock-names = "t0_clk", "slow_clk";
+			};
+
 			macb1: ethernet at fc028000 {
 				compatible = "atmel,sama5d4-gem";
 				reg = <0xfc028000 0x100>;
-- 
2.15.1
