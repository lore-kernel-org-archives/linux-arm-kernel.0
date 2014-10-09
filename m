From: mhei@heimpold.de (Michael Heimpold)
Date: Thu,  9 Oct 2014 23:45:46 +0200
Subject: [PATCH] ARM: dts: imx28: add alternative pinmuxing for pwm0 and can1
Message-ID: <1412891146-16679-1-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/imx28.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 47f68ac..d2d38b5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -641,6 +641,16 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				pwm0_pins_b: pwm0 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART1_RX__PWM_0
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				pwm2_pins_a: pwm2 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -801,6 +811,17 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				can1_pins_b: can1 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART3_CTS__CAN1_TX
+						MX28_PAD_AUART3_RTS__CAN1_RX
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				spi2_pins_a: spi2 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.10.4
