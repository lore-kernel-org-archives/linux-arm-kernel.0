From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 28 Oct 2016 09:56:41 -0700
Subject: [PATCH v2 4/5] ARM: dts: imx6q-evi: support cyclonespi
In-Reply-To: <cover.1477669744.git.stillcompiling@gmail.com>
References: <cover.1477669744.git.stillcompiling@gmail.com>
Message-ID: <36eb925f0c63c931bd406d1719e76e42b7d9432a.1477669745.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Altera cyclone V FPGA connected to an spi port

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6q-evi.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index 6de21ff..bd0b85c 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -95,6 +95,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
 	status = "okay";
+
+	fpga_spi: cyclonespi at 0 {
+		compatible = "altr,cyclone-ps-spi-fpga-mgr";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_fpgaspi>;
+		config-gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		status-gpio = <&gpio4 11 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &ecspi3 {
@@ -325,6 +334,13 @@
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
2.7.4
