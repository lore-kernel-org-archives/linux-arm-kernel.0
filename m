From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 24 Jan 2017 14:19:34 -0800
Subject: [PATCH v9 3/3] ARM: dts: imx6q-evi: support cyclone-ps-spi
In-Reply-To: <cover.1485295905.git.stillcompiling@gmail.com>
References: <cover.1485295905.git.stillcompiling@gmail.com>
Message-ID: <8466629f15d8c34be20d574012b0e829680a6393.1485295905.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Altera cyclone V FPGA connected to an spi port
to the evi devicetree file

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6q-evi.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index 79a0bd5..e531bf7 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -83,6 +83,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
 	status = "okay";
+
+	fpga_spi: cyclonespi at 0 {
+		compatible = "altr,fpga-passive-serial";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_fpgaspi>;
+		nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+		nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &ecspi3 {
@@ -316,6 +325,13 @@
 		>;
 	};
 
+	pinctrl_fpgaspi: fpgaspigrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09 0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11 0x1b0b0
+		>;
+	};
+
 	pinctrl_gpminand: gpminandgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_CLE__NAND_CLE 0xb0b1
-- 
2.9.3
