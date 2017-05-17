From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 17 May 2017 13:44:19 -0300
Subject: [PATCH] ARM: dts: omap3: Remove 'enable-active-low' property
Message-ID: <1495039459-23223-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Property 'enable-active-low' does not exist. Only 'enable-active-high' is
valid, and when this property is absent the gpio regulator will act as
active low by default.

So remove the unexisting 'enable-active-low' property. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/omap3-evm-common.dtsi | 1 -
 arch/arm/boot/dts/omap3-sb-t35.dtsi     | 1 -
 arch/arm/boot/dts/omap3-tao3530.dtsi    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 0904750..7780e25 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -76,7 +76,6 @@
 
 &lcd_3v3 {
 	gpio = <&gpio5 25 GPIO_ACTIVE_LOW>;	/* gpio153 */
-	enable-active-low;
 };
 
 &lcd0 {
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index 73643fa..91e15af 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -50,7 +50,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sb_t35_audio_amp>;
 		gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;   /* gpio_61 */
-		enable-active-low;
 		regulator-always-on;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index dc80886b..06ac0f8 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -63,7 +63,6 @@
 		regulator-min-microvolt = <3150000>;
 		regulator-max-microvolt = <3150000>;
 		gpio = <&gpio5 29 GPIO_ACTIVE_LOW>;		/* gpio_157 */
-		enable-active-low;
 		startup-delay-us = <10000>;
 	};
 };
-- 
2.7.4
