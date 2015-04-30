From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 30 Apr 2015 19:55:29 -0300
Subject: [PATCH 2/3] ARM: dts: imx6sl-warp: Remove USB regulators
In-Reply-To: <1430434530-12605-1-git-send-email-festevam@gmail.com>
References: <1430434530-12605-1-git-send-email-festevam@gmail.com>
Message-ID: <1430434530-12605-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to the warp schematics there are no regulators for the USB OTG 
ports, so let's remove them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 232597a..cec189a 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -58,32 +58,6 @@
 		reg = <0x80000000 0x20000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_usb_otg1_vbus: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_otg1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio4 0 0>;
-			enable-active-high;
-		};
-
-		reg_usb_otg2_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb_otg2_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio4 2 0>;
-			enable-active-high;
-		};
-	};
-
 	usdhc3_pwrseq: usdhc3_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>, 	/* WL_REG_ON */
@@ -113,14 +87,12 @@
 };
 
 &usbotg1 {
-	vbus-supply = <&reg_usb_otg1_vbus>;
 	dr_mode = "host";
 	disable-over-current;
 	status = "okay";
 };
 
 &usbotg2 {
-	vbus-supply = <&reg_usb_otg2_vbus>;
 	disable-over-current;
 	status = "okay";
 };
-- 
1.9.1
