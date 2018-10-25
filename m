From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Thu, 25 Oct 2018 17:09:33 +0200
Subject: [PATCH v1 4/4] ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch
 controller
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
Message-ID: <1540480173-12009-5-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ConnectCore 6UL SBC Pro has an AUO/Goodix LCD accessory kit that is
connected on the LVDS interface through an on-board LVDS transceiver.

This change adds support for the touch interface.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index f6e6b2cf780b..3749fdda3611 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -117,6 +117,19 @@
 	};
 };
 
+&i2c1 {
+	touchscreen at 14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_goodix_touch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+};
+
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat0_17
@@ -290,6 +303,12 @@
 		>;
 	};
 
+	pinctrl_goodix_touch: goodixgrp{
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1020
+		>;
+	};
+
 	pinctrl_lcdif_dat0_17: lcdifdatgrp0-17 {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
