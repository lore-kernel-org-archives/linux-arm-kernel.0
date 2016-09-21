From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 Sep 2016 00:09:39 +0200
Subject: [PATCH v2 6/6] ARM: dts: at91: sama5d2: Add securam node
In-Reply-To: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
References: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160921220939.27924-7-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5d2 has some static RAM that can be erased by the security module,
add its node

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 0b62bff86f49..a3653751a7d6 100644
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
+				reg = <0xf8044000 0x1420>;
+				clocks = <&securam_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0xf8044000 0x1420>;
+			};
+
 			rstc at f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
-- 
2.9.3
