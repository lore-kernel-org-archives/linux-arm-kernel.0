From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 12 Dec 2013 18:49:08 -0700
Subject: [PATCH V1 04/11] ARM: dts: imx6qdl-sabrelite: add comments for
 pinctrl_hog
In-Reply-To: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1386899355-17379-5-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a comment to tell the purpose of each pin. This
makes it easy to tell if it should go somewhere else.
i.e. the spi-nor cs could be put with pinctrl_ecspi1.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index c4aa504..be899d3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -114,13 +114,13 @@
 	imx6q-sabrelite {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x80000000
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
-				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
-				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
+/* uSDHC4 CD  */		MX6QDL_PAD_NANDF_D6__GPIO2_IO06	0x80000000
+/* spi-nor CS */		MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x80000000
+/* otg power en */		MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x80000000
+/* ethernet phy reset */	MX6QDL_PAD_EIM_D23__GPIO3_IO23	0x80000000
+/* USDHC3 CD  */		MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x80000000
+/* USDHC3 WP  */		MX6QDL_PAD_SD3_DAT4__GPIO7_IO01	0x1f0b0
+/* SGTL5000 sys_mclk  */	MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x80000000
 			>;
 		};
 
-- 
1.8.1.2
