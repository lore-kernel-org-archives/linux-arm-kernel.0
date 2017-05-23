From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 23 May 2017 12:32:43 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx23-sansa: Remove 'enable-active-low'
 property
Message-ID: <1495553564-19112-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property 'enable-active-low' does not exist. Only 'enable-active-high' is
valid, and when this property is absent the gpio regulator will act as
active low by default.

So remove the unexisting 'enable-active-low' property. 

Currently the GPIO flag is 0, which means active-high. In order to make
the dts description accurate, pass the GPIO_ACTIVE_LOW flag instead.

This change is safe because the gpio regulator driver does not take the
GPIO flag polarity into account.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Improve commit log and explain why this change is safe (Stefan).

 arch/arm/boot/dts/imx23-sansa.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 4ec32f4..221fd55 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -42,6 +42,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "imx23.dtsi"
 
 / {
@@ -149,9 +150,8 @@
 		regulator-name = "vdd-touchpad0";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio0 26 0>;
+		gpio = <&gpio0 26 GPIO_ACTIVE_LOW>;
 		regulator-always-on;
-		enable-active-low;
 	};
 
 	reg_vdd_tuner: regulator-vdd-tuner0 {
@@ -159,9 +159,8 @@
 		regulator-name = "vdd-tuner0";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio0 29 0>;
+		gpio = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		regulator-always-on;
-		enable-active-low;
 	};
 
 	backlight {
-- 
2.7.4
