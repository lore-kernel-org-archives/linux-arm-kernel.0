From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  5 Sep 2014 09:46:10 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Configure the pins locally
Message-ID: <1409921170-23935-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Passing '0x80000000' to the pin configuration means that kernel will skip the
IOMUXC_SW_PAD_CTL configuration and will use whathever values come from the 
bootloader.

Instead of relying on the bootloader setup, let's configure it in the kernel to
have predictable settings.

'0x1b0b0' is the default POR value for all these pins and has also been verified
that the pins are using this value by manually inspecting the IOMUXC_SW_PAD_CTL
registers, so no functional change has been made.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 07fb302..baf2f00 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -327,15 +327,15 @@
 	imx6qdl-sabresd {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x80000000
-				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
-				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
-				MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
+				MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x1b0b0
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x1b0b0
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x1b0b0
+				MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x1b0b0
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
-				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x80000000
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
-				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
+				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x1b0b0
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x1b0b0
+				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x1b0b0
 			>;
 		};
 
@@ -380,9 +380,9 @@
 
 		pinctrl_gpio_keys: gpio_keysgrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x80000000
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x80000000
-				MX6QDL_PAD_GPIO_5__GPIO1_IO05  0x80000000
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b0
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x1b0b0
+				MX6QDL_PAD_GPIO_5__GPIO1_IO05  0x1b0b0
 			>;
 		};
 
@@ -409,7 +409,7 @@
 
 		pinctrl_pcie: pciegrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x80000000
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x1b0b0
 			>;
 		};
 
@@ -487,7 +487,7 @@
 	gpio_leds {
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x1b0b0
 			>;
 		};
 	};
-- 
1.9.1
