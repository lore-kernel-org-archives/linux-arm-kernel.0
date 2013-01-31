From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Jan 2013 11:00:23 +0100
Subject: [PATCH 1/2] ARM: mxs: dts: Add gpio-keys for the rotary to the
 CFA-10049
In-Reply-To: <1359626424-22546-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359626424-22546-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359626424-22546-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index cabc33a..5db3789 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -45,6 +45,7 @@
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x2133 /* MX28_PAD_SSP2_D3__GPIO_2_19 */
+						0x31a3 /* MX28_PAD_SAIF_SDATA0__GPIO_3_26 */
 						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
 					>;
 					fsl,drive-strength = <0>;
@@ -276,6 +277,19 @@
 		};
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rotary_button {
+			label = "rotary_button";
+			gpios = <&gpio3 26 1>;
+			debounce-interval = <10>;
+			linux,code = <28>;
+		};
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 3 5000000>;
-- 
1.7.10.4
