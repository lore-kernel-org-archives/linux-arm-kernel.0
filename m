From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 15:32:46 +0200
Subject: [PATCH 3/3] arm64: dts: mt8173: Add PMIC wrapper device node
In-Reply-To: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
References: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432128766-4445-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device node for the PMIC wrapper.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 02088a6..a97b2aa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt8173-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset-controller/mt8173-resets.h>
 #include "mt8173-pinfunc.h"
 
 / {
@@ -158,6 +159,17 @@
 			reg = <0 0x10005000 0 0x1000>;
 		};
 
+		pwrap: pwrap at 1000d000 {
+			compatible = "mediatek,mt8173-pwrap";
+			reg = <0 0x1000d000 0 0x1000>;
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
