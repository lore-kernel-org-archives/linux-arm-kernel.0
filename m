From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Jan 2013 11:00:24 +0100
Subject: [PATCH 2/2] ARM: mxs: dts: Add rotary encoder to the CFA-10049
In-Reply-To: <1359626424-22546-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359626424-22546-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359626424-22546-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 5db3789..a0d3e9f 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -45,6 +45,8 @@
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x2133 /* MX28_PAD_SSP2_D3__GPIO_2_19 */
+						0x3183 /* MX28_PAD_I2C0_SCL__GPIO_3_24 */
+						0x3193 /* MX28_PAD_I2C0_SDA__GPIO_3_25 */
 						0x31a3 /* MX28_PAD_SAIF_SDATA0__GPIO_3_26 */
 						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
 					>;
@@ -290,6 +292,13 @@
 		};
 	};
 
+	rotary {
+		compatible = "rotary-encoder";
+		gpios = <&gpio3 24 1>, <&gpio3 25 1>;
+		linux,axis = <1>; /* REL_Y */
+		rotary-encoder,relative-axis;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 3 5000000>;
-- 
1.7.10.4
