From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 5 Feb 2014 11:10:09 -0200
Subject: [PATCH 1/2] ARM: dts: mx53: Remove 'enable-active-low' property
Message-ID: <1391605810-3285-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'enable-active-low' is not a valid property for a GPIO controlled regulator.

According to Documentation/devicetree/bindings/regulator/gpio-regulator.txt:

"Optional properties:
...
- enable-active-high	: Polarity of GPIO is active high (default is low)."

,so the correct way to define an active-low GPIO controlled regulator is to 
simply not pass 'enable-active-high'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 1 -
 arch/arm/boot/dts/imx53-mba53.dts  | 1 -
 arch/arm/boot/dts/imx53-tx53.dtsi  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 7100d08..e8d11e2 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -103,7 +103,6 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio1 2 0>;
-			enable-active-low;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 0358366..55af110 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -46,7 +46,6 @@
 			regulator-name = "lcd-supply";
 			gpio = <&gpio2 5 0>;
 			startup-delay-us = <5000>;
-			enable-active-low;
 		};
 
 		reg_3p2v: regulator at 1 {
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index a44403a..e348796 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -96,7 +96,6 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_can_xcvr>;
 			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
-			enable-active-low;
 		};
 
 		reg_usbh1_vbus: regulator at 3 {
-- 
1.8.1.2
