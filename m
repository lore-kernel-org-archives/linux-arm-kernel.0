From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:54 -0700
Subject: [PATCH V2 04/13] ARM: dts: imx6qdl-sabrelite: move spi-nor CS to
 pinctrl_ecspi1
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-5-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves pin EIM_D19 (CS) from pinctrl_hog to pinctrl_ecspi1.
It also explicitly sets the pad to 0x000b1.

Before this patch, it has the value 0x100b1 if using mainline u-boot.
So this patch also removes hysteresis since the pad is always an output.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: New patch.. V1 patch to add comments was broken up into
multiple patches
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 96c3902..90d99bf 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -114,7 +114,6 @@
 	imx6q-sabrelite {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
@@ -126,7 +125,10 @@
 		};
 
 		pinctrl_ecspi1: ecspi1grp {
-			fsl,pins = <MX6QDL_ECSPI1_PINGRP1>;
+			fsl,pins = <
+				MX6QDL_ECSPI1_PINGRP1
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x000b1	/* CS */
+			>;
 		};
 
 		pinctrl_enet: enetgrp {
-- 
1.8.1.2
