From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 17 May 2017 13:43:00 -0300
Subject: [PATCH 1/2] ARM: dts: imx23-sansa: Remove 'enable-active-low' property
Message-ID: <1495039381-23126-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property 'enable-active-low' does not exist. Only 'enable-active-high' is
valid, and when this property is absent the gpio regulator will act as
active low by default.

So remove the unexisting 'enable-active-low' property. 

While at it, in order to make the gpio regulator description clearer pass
the GPIO_ACTIVE_LOW flag.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
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
