From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:19 +0200
Subject: [PATCH 38/58] ARM: dts: at91: sama5d4: Add TCB2
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-39-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third TC block is missing from the dtsi. It has no output pins but can
still be used as a clocksource/clockevents device as the IRQ is wired.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 73d38326cc43..1ff956ad159d 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1193,6 +1193,16 @@
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
2.11.0
