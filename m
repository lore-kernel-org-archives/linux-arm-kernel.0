From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 12 Nov 2012 16:26:18 +0800
Subject: [PATCH 1/1] ARM: dts: imx6q-sabresd: add volume up/down gpio keys
Message-ID: <1352708778-25570-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add volume up/down gpio keys support in imx6q-sabresd.dts.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabresd.dts |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index e596c28..a424025 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -38,6 +38,8 @@
 				hog {
 					pinctrl_hog: hoggrp {
 						fsl,pins = <
+							1004 0x80000000 /* MX6Q_PAD_GPIO_4__GPIO_1_4 */
+							1012 0x80000000 /* MX6Q_PAD_GPIO_5__GPIO_1_5 */
 							1402 0x80000000	/* MX6Q_PAD_NANDF_D0__GPIO_2_0 */
 							1410 0x80000000	/* MX6Q_PAD_NANDF_D1__GPIO_2_1 */
 							1418 0x80000000	/* MX6Q_PAD_NANDF_D2__GPIO_2_2 */
@@ -73,4 +75,20 @@
 			};
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio1 4 0>;
+			linux,code = <115>; /* KEY_VOLUMEUP */
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio1 5 0>;
+			linux,code = <114>; /* KEY_VOLUMEDOWN */
+		};
+	};
 };
-- 
1.7.1
