From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:53 -0700
Subject: [PATCH V2 03/13] ARM: dts: imx6qdl-sabrelite: move USDHC3 CD/WP to
 pinctrl_usdhc3
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-4-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves pin SD3_DAT5/4 (CD/WP) from pinctrl_hog to pinctrl_usdhc3.
It also explicitly sets the pad SD3_DAT5 to 0x1b0b0, which is also the value
that it has before this patch if using mainline u-boot.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: New patch.. V1 patch to add comments was broken up into
multiple patches
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 8bb910b..96c3902 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -117,8 +117,6 @@
 				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
-				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
 			>;
 		};
@@ -152,7 +150,11 @@
 		};
 
 		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <MX6QDL_USDHC3_PINGRP_D4>;
+			fsl,pins = <
+				MX6QDL_USDHC3_PINGRP_D4
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x1b0b0	/* CD */
+				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0	/* WP */
+			>;
 		};
 
 		pinctrl_usdhc4: usdhc4grp {
-- 
1.8.1.2
