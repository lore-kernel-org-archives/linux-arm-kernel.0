From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu,  6 Oct 2016 13:34:19 -0700
Subject: [PATCH 3/3] ARM: dts: imx6q-evi: support cyclonespi
In-Reply-To: <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
References: <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
Message-ID: <16ba10d2523a6f0eaf40246dfbd9e660f297fd22.1475783742.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Altera cyclone V FPGA connected to an spi port

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6q-evi.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index 6de21ff..7e5d3cf 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -95,6 +95,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
 	status = "okay";
+
+	fpga_spi: cyclonespi at 0 {
+		compatible = "altr,cyclonespi-fpga-mgr";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_fpgaspi>;
+		reset-gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
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
