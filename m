From: stefan@agner.ch (Stefan Agner)
Date: Sun, 17 Dec 2017 21:37:21 +0100
Subject: [PATCH v2 7/9] ARM: dts: imx7-colibri: specify backlight GPIO
In-Reply-To: <20171217203723.15896-1-stefan@agner.ch>
References: <20171217203723.15896-1-stefan@agner.ch>
Message-ID: <20171217203723.15896-7-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colibri standard defines SODIMM 71 as backlight enable
GPIO. Assign the GPIO to the backlight node in the module
level device tree.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index d623ef0f6e3e..689ff6822634 100644
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
@@ -360,7 +363,6 @@
 		fsl,pins = <
 			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x14 /* SODIMM 65 */
 			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x74 /* SODIMM 69 */
-			MX7D_PAD_SD1_WP__GPIO5_IO1		0x14 /* SODIMM 71 */
 			MX7D_PAD_I2C4_SDA__GPIO4_IO15		0x14 /* SODIMM 75 */
 			MX7D_PAD_ECSPI1_MISO__GPIO4_IO18	0x14 /* SODIMM 79 */
 			MX7D_PAD_I2C3_SCL__GPIO4_IO12		0x14 /* SODIMM 81 */
@@ -436,6 +438,12 @@
 		>;
 	};
 
+	pinctrl_gpio_bl_on: gpio-bl-on {
+		fsl,pins = <
+			MX7D_PAD_SD1_WP__GPIO5_IO1		0x14 /* SODIMM 71 */
+		>;
+	};
+
 	pinctrl_gpmi_nand: gpmi-nand-grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CLK__NAND_CLE		0x71
-- 
2.15.1
