From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 13 Apr 2016 15:07:44 +0800
Subject: [RESEND PATCH 2/2] arm: dts: Add pinctrl/GPIO/EINT node for mt2701
In-Reply-To: <1460531264-4405-1-git-send-email-biao.huang@mediatek.com>
References: <1460531264-4405-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1460531264-4405-3-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl and GPIO node to mt2701.dtsi

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch has been reverted in 7aec2fd74add9c4a61d77f51c805b4f7592956da
We have checked it can build pass in kernel-4.6 rc1
---
 arch/arm/boot/dts/mt2701.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 88364f0..da5fef8 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton64.dtsi"
+#include "mt2701-pinfunc.h"
 
 / {
 	compatible = "mediatek,mt2701";
@@ -115,6 +116,24 @@
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
 	scpsys: scpsys at 10006000 {
 		compatible = "mediatek,mt2701-scpsys", "syscon";
 		#power-domain-cells = <1>;
-- 
1.7.9.5
