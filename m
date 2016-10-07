From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Fri, 7 Oct 2016 20:41:29 +0530
Subject: [PATCH v3 6/6] arm: dts: imx7-colibri: Use enable-gpios for BL_ON
In-Reply-To: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
Message-ID: <20161007151129.6043-7-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pwm-backlight driver 'enable-gpios' property for backlight on/off control.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 2af5e3e..ce5edb5 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -43,7 +43,10 @@
 / {
 	bl: backlight {
 		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_bl_on>;
 		pwms = <&pwm1 0 5000000 0>;
+		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_module_3v3: regulator-module-3v3 {
@@ -356,7 +359,6 @@
 		fsl,pins = <
 			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x14 /* SODIMM 65 */
 			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x14 /* SODIMM 69 */
-			MX7D_PAD_SD1_WP__GPIO5_IO1		0x14 /* SODIMM 71 */
 			MX7D_PAD_I2C4_SDA__GPIO4_IO15		0x14 /* SODIMM 75 */
 			MX7D_PAD_ECSPI1_MISO__GPIO4_IO18	0x14 /* SODIMM 79 */
 			MX7D_PAD_I2C3_SCL__GPIO4_IO12		0x14 /* SODIMM 81 */
@@ -388,6 +390,12 @@
 		>;
 	};
 
+		pinctrl_gpio_bl_on: gpio-bl-on {
+			fsl,pins = <
+				MX7D_PAD_SD1_WP__GPIO5_IO1		0x14
+			>;
+		};
+
 	pinctrl_i2c1_int: i2c1-int-grp { /* PMIC / TOUCH */
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x79
-- 
2.10.0
