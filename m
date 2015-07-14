From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:39 +0200
Subject: [PATCH 04/17] ARM: dts: lpc18xx: add gpio node
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio and mapping between pinctrl/gpio namespace with
gpio-ranges property.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 32c3feceff6e..60dc929568b3 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -16,6 +16,9 @@
 #include "dt-bindings/clock/lpc18xx-cgu.h"
 #include "dt-bindings/clock/lpc18xx-ccu.h"
 
+#define LPC_PIN(port, pin)	(0x##port * 32 + pin)
+#define LPC_GPIO(port, pin)	(port * 32 + pin)
+
 / {
 	cpus {
 		#address-cells = <1>;
@@ -177,5 +180,53 @@
 			clocks = <&ccu1 CLK_CPU_TIMER3>;
 			clock-names = "timerclk";
 		};
+
+		gpio: gpio at 400f4000 {
+			compatible = "nxp,lpc1850-gpio";
+			reg = <0x400f4000 0x4000>;
+			clocks = <&ccu1 CLK_CPU_GPIO>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges =	<&pinctrl LPC_GPIO(0,0)  LPC_PIN(0,0)  2>,
+					<&pinctrl LPC_GPIO(0,4)  LPC_PIN(1,0)  1>,
+					<&pinctrl LPC_GPIO(0,8)  LPC_PIN(1,1)  4>,
+					<&pinctrl LPC_GPIO(1,8)  LPC_PIN(1,5)  2>,
+					<&pinctrl LPC_GPIO(1,0)  LPC_PIN(1,7)  8>,
+					<&pinctrl LPC_GPIO(0,2)  LPC_PIN(1,15) 2>,
+					<&pinctrl LPC_GPIO(0,12) LPC_PIN(1,17) 2>,
+					<&pinctrl LPC_GPIO(0,15) LPC_PIN(1,20) 1>,
+					<&pinctrl LPC_GPIO(5,0)  LPC_PIN(2,0)  7>,
+					<&pinctrl LPC_GPIO(0,7)  LPC_PIN(2,7)  1>,
+					<&pinctrl LPC_GPIO(5,7)  LPC_PIN(2,8)  1>,
+					<&pinctrl LPC_GPIO(1,10) LPC_PIN(2,9)  1>,
+					<&pinctrl LPC_GPIO(0,14) LPC_PIN(2,10) 1>,
+					<&pinctrl LPC_GPIO(1,11) LPC_PIN(2,11) 3>,
+					<&pinctrl LPC_GPIO(5,8)  LPC_PIN(3,1)  2>,
+					<&pinctrl LPC_GPIO(1,14) LPC_PIN(3,4)  2>,
+					<&pinctrl LPC_GPIO(0,6)  LPC_PIN(3,6)  1>,
+					<&pinctrl LPC_GPIO(5,10) LPC_PIN(3,7)  2>,
+					<&pinctrl LPC_GPIO(2,0)  LPC_PIN(4,0)  7>,
+					<&pinctrl LPC_GPIO(5,12) LPC_PIN(4,8)  3>,
+					<&pinctrl LPC_GPIO(2,9)  LPC_PIN(5,0)  7>,
+					<&pinctrl LPC_GPIO(2,7)  LPC_PIN(5,7)  1>,
+					<&pinctrl LPC_GPIO(3,0)  LPC_PIN(6,1)  5>,
+					<&pinctrl LPC_GPIO(0,5)  LPC_PIN(6,6)  1>,
+					<&pinctrl LPC_GPIO(5,15) LPC_PIN(6,7)  2>,
+					<&pinctrl LPC_GPIO(3,5)  LPC_PIN(6,9)  3>,
+					<&pinctrl LPC_GPIO(2,8)  LPC_PIN(6,12) 1>,
+					<&pinctrl LPC_GPIO(3,8)  LPC_PIN(7,0)  8>,
+					<&pinctrl LPC_GPIO(4,0)  LPC_PIN(8,0)  8>,
+					<&pinctrl LPC_GPIO(4,12) LPC_PIN(9,0)  4>,
+					<&pinctrl LPC_GPIO(5,17) LPC_PIN(9,4)  2>,
+					<&pinctrl LPC_GPIO(4,11) LPC_PIN(9,6)  1>,
+					<&pinctrl LPC_GPIO(4,8)  LPC_PIN(a,1)  3>,
+					<&pinctrl LPC_GPIO(5,19) LPC_PIN(a,4)  1>,
+					<&pinctrl LPC_GPIO(5,20) LPC_PIN(b,0)  7>,
+					<&pinctrl LPC_GPIO(6,0)  LPC_PIN(c,1) 14>,
+					<&pinctrl LPC_GPIO(6,14) LPC_PIN(d,0) 17>,
+					<&pinctrl LPC_GPIO(7,0)  LPC_PIN(e,0) 16>,
+					<&pinctrl LPC_GPIO(7,16) LPC_PIN(f,1)  3>,
+					<&pinctrl LPC_GPIO(7,19) LPC_PIN(f,5)  7>;
+		};
 	};
 };
-- 
1.8.0
