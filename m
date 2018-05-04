From: shawnguo@kernel.org (Shawn Guo)
Date: Fri,  4 May 2018 17:27:09 +0800
Subject: [PATCH 1/2] ARM: dts: imx6sx-sabreauto: drop 'regulators' container
 node
Message-ID: <1525426030-17221-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's drop the 'regulators' container node by giving VCC_SD3 an unique
name and removing 'reg' property, so that the fixed regulator can be
under root node directly.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 57d1ea0a3f8e..e5c1d6daa5e0 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,22 +18,15 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vcc_sd3: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_vcc_sd3>;
-			regulator-name = "VCC_SD3";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-			gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	vcc_sd3: regulator-vcc-sd3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_vcc_sd3>;
+		regulator-name = "VCC_SD3";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 };
 
-- 
1.9.1
