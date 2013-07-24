From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Jul 2013 18:35:28 +0200
Subject: [PATCH 1/2] ARM i.MX6Q: dts: Enable SPI NOR flash on Phytec
 phyFLEX-i.MX6 Ouad module
Message-ID: <1374683729-13438-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index f5e1981..5113d29 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -20,6 +20,20 @@
 	};
 };
 
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3_1>;
+	status = "okay";
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 24 0>;
+
+	flash: m25p80 at 0 {
+		compatible = "m25p80";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -28,6 +42,7 @@
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
 				MX6Q_PAD_EIM_D23__GPIO3_IO23    0x80000000
+				MX6Q_PAD_DISP0_DAT3__GPIO4_IO24	0x80000000 /* SPI NOR chipselect */
 			>;
 		};
 	};
-- 
1.8.3.2
