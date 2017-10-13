From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 13 Oct 2017 12:42:57 +0200
Subject: [PATCH 1/7] ARM: dts: imx6ul-txul: enable I2C bus recovery
In-Reply-To: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507891383-15452-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the required properties to enable I2C bus recovery supported by
the I2C subsystem.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index ec745eb..d30c4e05 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2015-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -357,8 +357,11 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
 	clock-frequency = <400000>;
 	status = "okay";
 
@@ -817,6 +820,13 @@
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2-gpiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x4001b0b9
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x4001b0b9
+		>;
+	};
+
 	pinctrl_kpp: kppgrp {
 		fsl,pins = <
 			MX6UL_PAD_ENET2_RX_DATA1__KPP_COL04	0x1b0b0
-- 
2.1.4
