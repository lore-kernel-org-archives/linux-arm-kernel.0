From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  7 May 2018 08:39:52 -0300
Subject: [PATCH] ARM: dts: imx28-tx28: Fix alias DTC warnings
Message-ID: <1525693192-3579-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove underscore from alias entries to fix the following DTC warnings
with W=1:

arch/arm/boot/dts/imx28-tx28.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-tx28.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index e4f19f9b..a5d6c97 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -56,11 +56,11 @@
 		ds1339 = &ds1339;
 		gpio5 = &gpio5;
 		lcdif = &lcdif;
-		lcdif_23bit_pins = &tx28_lcdif_23bit_pins;
-		lcdif_24bit_pins = &lcdif_24bit_pins_a;
-		reg_can_xcvr = &reg_can_xcvr;
-		spi_gpio = &spi_gpio;
-		spi_mxs = &ssp3;
+		lcdif-23bit-pins = &tx28_lcdif_23bit_pins;
+		lcdif-24bit-pins = &lcdif_24bit_pins_a;
+		reg-can-xcvr = &reg_can_xcvr;
+		spigpio = &spi_gpio;
+		spi-mxs = &ssp3;
 		stk5led = &user_led;
 		usbotg = &usb0;
 	};
@@ -220,7 +220,7 @@
 		linux,no-autorepeat;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.7.4
