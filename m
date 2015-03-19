From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 19 Mar 2015 10:55:47 +0100
Subject: [PATCH] ARM: dts: imx28: add alternative pinmuxing for spi3
Message-ID: <1426758947-18003-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello Shawn,

the .dts that uses this pinmuxing is for a customer board that is not
supposed to go into mainline. Still the pinmuxing going in is very helpful
because I cannot define it in the machine.dts.

So it would be great if you could pick this up even without an user.

Best regards
Uwe

 arch/arm/boot/dts/imx28.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 02330f4aba41..25e25f82fbae 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -829,6 +829,19 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				spi3_pins_b: spi3 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP3_SCK__SSP3_SCK
+						MX28_PAD_SSP3_MOSI__SSP3_CMD
+						MX28_PAD_SSP3_MISO__SSP3_D0
+						MX28_PAD_SSP3_SS0__SSP3_D3
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
 				usb0_pins_a: usb0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.1.4
