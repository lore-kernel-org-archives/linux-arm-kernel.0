From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 May 2015 12:53:44 +0200
Subject: [PATCH 3/3] ARM64: dts: mt8173: Add PMIC wrapper device node
In-Reply-To: <1432032824-7955-1-git-send-email-s.hauer@pengutronix.de>
References: <1432032824-7955-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432032824-7955-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device node for the PMIC wrapper.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index cfdca03..16ec639 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "mt8173-pinfunc.h"
+#include <dt-bindings/reset-controller/mt8173-resets.h>
 #include <dt-bindings/clock/mt8173-clk.h>
 
 / {
@@ -154,6 +155,17 @@
 						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pwrap: pwrap at 1000D000 {
+			compatible = "mediatek,mt8173-pwrap";
+			reg = <0 0x1000D000 0 0x1000>;
+			reg-names = "pwrap";
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&infracfg MT8173_INFRA_PMIC_WRAP_RST>;
+			reset-names = "pwrap";
+			clocks = <&infracfg CLK_INFRA_PMICSPI>, <&infracfg CLK_INFRA_PMICWRAP>;
+			clock-names = "spi", "wrap";
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 					"mediatek,mt6577-sysirq";
-- 
2.1.4
