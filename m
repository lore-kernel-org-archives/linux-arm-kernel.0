From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 31 Mar 2016 14:33:42 +0200
Subject: [PATCHv3 2/5] ARM: dts: imx6-tx6: remove LED pinctrl setting from
 hoggrp
In-Reply-To: <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
References: <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1459427625-15568-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pinctrl setting for the board LED from the hoggrp node
to a separate node referenced by the LED driver, so that the pin is
free to be used for different purpose when the LED driver is disabled.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index a3e37a7..d96dba2 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -88,6 +88,8 @@
 
 		user_led: user {
 			label = "Heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_user_led>;
 			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
@@ -328,7 +330,6 @@
 
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_A18__GPIO2_IO20		0x1b0b1 /* LED */
 			MX6QDL_PAD_SD3_DAT2__GPIO7_IO06		0x1b0b1 /* ETN PHY RESET */
 			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x1b0b1 /* ETN PHY INT */
 			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x1b0b1 /* PWR BTN */
@@ -634,6 +635,12 @@
 			MX6QDL_PAD_SD3_CLK__GPIO7_IO03		0x170b0 /* SD2 CD */
 		>;
 	};
+
+	pinctrl_user_led: user-ledgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A18__GPIO2_IO20		0x1b0b1 /* LED */
+		>;
+	};
 };
 
 &kpp {
-- 
2.1.4
