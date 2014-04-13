From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 09:19:07 +0400
Subject: [PATCH 04/10] ARM: dts: imx51-babbage: Move "hog" pins into
 corresponded pin groups
In-Reply-To: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397366353-29395-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move "hog" pins into corresponded pin groups for eSDHC1, eSDHC2 and
eCSPI1.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 3312736..1bdb863 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -329,21 +329,7 @@
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
 	imx51-babbage {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX51_PAD_GPIO1_0__SD1_CD     0x20d5
-				MX51_PAD_GPIO1_1__SD1_WP     0x20d5
-				MX51_PAD_GPIO1_5__GPIO1_5    0x100
-				MX51_PAD_GPIO1_6__GPIO1_6    0x100
-				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
-				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
-			>;
-		};
-
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX51_PAD_AUD3_BB_TXD__AUD3_TXD		0x80000000
@@ -364,6 +350,8 @@
 				MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
 				MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x185
 				MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x185
+				MX51_PAD_CSPI1_SS0__GPIO4_24		0x85 /* CS0 */
+				MX51_PAD_CSPI1_SS1__GPIO4_25		0x85 /* CS1 */
 			>;
 		};
 
@@ -375,6 +363,8 @@
 				MX51_PAD_SD1_DATA1__SD1_DATA1		0x20d5
 				MX51_PAD_SD1_DATA2__SD1_DATA2		0x20d5
 				MX51_PAD_SD1_DATA3__SD1_DATA3		0x20d5
+				MX51_PAD_GPIO1_0__SD1_CD		0x20d5
+				MX51_PAD_GPIO1_1__SD1_WP		0x20d5
 			>;
 		};
 
@@ -386,6 +376,8 @@
 				MX51_PAD_SD2_DATA1__SD2_DATA1		0x20d5
 				MX51_PAD_SD2_DATA2__SD2_DATA2		0x20d5
 				MX51_PAD_SD2_DATA3__SD2_DATA3		0x20d5
+				MX51_PAD_GPIO1_5__GPIO1_5		0x100 /* WP */
+				MX51_PAD_GPIO1_6__GPIO1_6		0x100 /* CD */
 			>;
 		};
 
-- 
1.8.3.2
