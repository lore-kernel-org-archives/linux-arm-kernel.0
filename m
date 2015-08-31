From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Aug 2015 09:34:06 +0200
Subject: [PATCH 3/3] ARM64: dts: mt8173: Add thermal/auxadc device nodes
In-Reply-To: <1441006446-4558-1-git-send-email-s.hauer@pengutronix.de>
References: <1441006446-4558-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1441006446-4558-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 27237a1..ddacb86 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -151,6 +151,11 @@
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
@@ -186,6 +191,18 @@
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
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
 	};
 };
 
-- 
2.5.0
