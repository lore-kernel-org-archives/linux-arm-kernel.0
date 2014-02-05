From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 5 Feb 2014 11:10:10 -0200
Subject: [PATCH 2/2] ARM: dts: imx28-tx28: Remove 'enable-active-low' property
In-Reply-To: <1391605810-3285-1-git-send-email-fabio.estevam@freescale.com>
References: <1391605810-3285-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1391605810-3285-2-git-send-email-fabio.estevam@freescale.com>
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
 arch/arm/boot/dts/imx28-tx28.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 3c54e8d..e14bd86 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -91,7 +91,6 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio1 0 0>;
-			enable-active-low;
 			pinctrl-names = "default";
 			pinctrl-0 = <&tx28_flexcan_xcvr_pins>;
 		};
-- 
1.8.1.2
