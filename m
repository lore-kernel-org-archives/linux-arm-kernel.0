From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 May 2015 10:52:43 +0200
Subject: [PATCH 15/15] ARM64: dts: mt8173: Add thermal/auxadc device nodes
In-Reply-To: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1431507163-19933-16-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 924fdb6..50d424f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -147,6 +147,11 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		auxadc: auxadc at 11001000 {
+			compatible = "mediatek,mt8173-auxadc";
+			reg = <0 0x11001000 0 0x1000>;
+		};
+
 		uart0: serial at 11002000 {
 			compatible = "mediatek,mt8173-uart",
 					"mediatek,mt6577-uart";
@@ -182,6 +187,19 @@
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
+
+		thermal: thermal at 1100b000 {
+			#thermal-sensor-cells = <1>;
+			compatible = "mediatek,mt8173-thermal";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+			clock-names = "therm", "auxadc";
+			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+			reset-names = "therm";
+			auxadc = <&auxadc>;
+			apmixedsys = <&apmixedsys>;
+		};
 	};
 
 };
-- 
2.1.4
