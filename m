From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  7 May 2014 20:09:05 +0200
Subject: [PATCH 2/2] ARM: dts: imx6: edmqmx6: add SPI bus and flash
In-Reply-To: <1399486145-24913-1-git-send-email-l.stach@pengutronix.de>
References: <1399486145-24913-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1399486145-24913-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index be5de70fe86a..58791d0eaaf8 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -91,6 +91,20 @@
 	};
 };
 
+&ecspi5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi5>;
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio1 12 0>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		compatible = "m25p80";
+		spi-max-frequency = <40000000>;
+		reg = <0>;
+	};
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
@@ -264,6 +278,15 @@
 			>;
 		};
 
+		pinctrl_ecspi5: ecspi5rp-1 {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT0__ECSPI5_MISO	0x80000000
+				MX6QDL_PAD_SD1_CMD__ECSPI5_MOSI		0x80000000
+				MX6QDL_PAD_SD1_CLK__ECSPI5_SCLK		0x80000000
+				MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x80000000
+			>;
+		};
+
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
 				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
-- 
2.0.0.rc0
