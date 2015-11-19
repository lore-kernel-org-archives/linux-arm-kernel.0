From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 19 Nov 2015 12:02:24 -0800
Subject: [PATCH 2/2] ARM: dts: imx: ventana: Add SPI support for GW52xx
Message-ID: <1447963344-21996-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This addes support for SPI available on an off-board connector available on
some models of the GW52xx.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index e4a1e72..7fc45a4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -158,6 +158,14 @@
 	                  <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 };
 
+&ecspi3 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
@@ -357,6 +365,15 @@
 			>;
 		};
 
+		pinctrl_ecspi3: escpi3grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
+				MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
+				MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
+				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x100b1
+			>;
+		};
+
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
 				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
-- 
1.9.1
