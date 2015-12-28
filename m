From: biao.huang@mediatek.com (Biao Huang)
Date: Mon, 28 Dec 2015 15:09:06 +0800
Subject: [PATCH v3 5/5] arm: dts: Add pinctrl/GPIO/EINT node for mt2701
In-Reply-To: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
References: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1451286546-5920-6-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl and GPIO node to mt2701.dtsi

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/mt2701.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index dc02f76..bd88ae9 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/clock/mt2701-clk.h>
 #include <dt-bindings/reset-controller/mt2701-resets.h>
 #include "skeleton64.dtsi"
+#include "mt2701-pinfunc.h"
 
 / {
 	compatible = "mediatek,mt2701";
@@ -99,6 +100,24 @@
 		#reset-cells = <1>;
 	};
 
+	pio: pinctrl at 10005000 {
+		compatible = "mediatek,mt2701-pinctrl";
+		reg = <0 0x1000b000 0 0x1000>;
+		mediatek,pctl-regmap = <&syscfg_pctl_a>;
+		pins-are-numbered;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	syscfg_pctl_a: syscfg at 10005000 {
+		compatible = "mediatek,mt2701-pctl-a-syscfg", "syscon";
+		reg = <0 0x10005000 0 0x1000>;
+	};
+
 	watchdog: watchdog at 10007000 {
 		compatible = "mediatek,mt2701-wdt",
 			     "mediatek,mt6589-wdt";
-- 
1.7.9.5
