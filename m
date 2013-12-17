From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:55 -0700
Subject: [PATCH V2 05/13] ARM: dts: imx6qdl-sabrelite: move usbotg power
 enable to pinctrl_usbotg
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-6-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves pin EIM_D22(power enable) from pinctrl_hog to pinctrl_usbotg.
It also explicitly sets the pad to 0x000b0, which is also the value
that it has before this patch if using mainline u-boot.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: New patch.. V1 patch to add comments was broken up into
multiple patches
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 90d99bf..2654ff1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -114,7 +114,6 @@
 	imx6q-sabrelite {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
 			>;
@@ -148,7 +147,11 @@
 		};
 
 		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <MX6QDL_USBOTG_PINGRP1>;
+			fsl,pins = <
+				MX6QDL_USBOTG_PINGRP1
+				/* power enable, high active */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x000b0
+			>;
 		};
 
 		pinctrl_usdhc3: usdhc3grp {
-- 
1.8.1.2
