From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 Aug 2016 18:11:05 +0200
Subject: [PATCH 2/5] ARM: dts: at91: sama5d2: Add secumod node
In-Reply-To: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
References: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160831161108.8780-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5d2 has a security module, add its node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 353d0e5ec83b..b027e96e40ef 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -706,6 +706,11 @@
 						atmel,clk-output-range = <0 83000000>;
 					};
 
+					securam_clk: securam_clk {
+						#clock-cells = <0>;
+						reg = <51>;
+					};
+
 					i2s0_clk: i2s0_clk {
 						#clock-cells = <0>;
 						reg = <54>;
@@ -1029,6 +1034,15 @@
 				status = "disabled";
 			};
 
+			securam: sram at f8044000 {
+				compatible = "atmel,sama5d2-securam", "mmio-sram";
+				reg = <0xf8044000 0x40000>;
+				clocks = <&securam_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0xf8044000 0x1420>;
+			};
+
 			rstc at f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
@@ -1231,6 +1245,11 @@
 				clocks = <&pioA_clk>;
 			};
 
+			secumod at fc040000 {
+				compatible = "atmel,sama5d2-secumod", "syscon";
+				reg = <0xfc040000 0x100>;
+			};
+
 			tdes at fc044000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc044000 0x100>;
-- 
2.9.3
