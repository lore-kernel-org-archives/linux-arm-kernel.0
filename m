From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:05:38 +0200
Subject: [PATCH 3/4] ARM: dts: imx28-tx28: fix interrupt flags and use
 interrupts-extended property
In-Reply-To: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
References: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507719939-27250-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the correct interrupt flags and change the 'interrupt-parent',
'interrupts' property pairs to 'interrupts-extended'.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 211e67d..3c852f7 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -328,8 +328,7 @@
 		reg = <0x20>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tx28_pca9554_pins>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <28 0>;
+		interrupts-extended = <&gpio3 28 IRQ_TYPE_NONE>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
@@ -341,8 +340,7 @@
 		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tx28_edt_ft5x06_pins>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&gpio2 5 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
 	};
@@ -352,8 +350,7 @@
 		reg = <0x48>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tx28_tsc2007_pins>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <20 0>;
+		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
 		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = /bits/ 16 <660>;
 	};
-- 
2.1.4
