From: mans@mansr.com (Mans Rullgard)
Date: Sun, 10 Jan 2016 12:40:12 +0000
Subject: [PATCH] ARM: dts: imx28: add pinmux for USB1 overcurrent on pwm2
Message-ID: <1452429613-28783-1-git-send-email-mans@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux setting for USB1 overcurrent on pwm2 pad.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/boot/dts/imx28.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index fae7b9069fc4..2f5cbf7d09f2 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -883,6 +883,16 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				usb1_pins_b: usb1 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_PWM2__USB1_OVERCURRENT
+					>;
+					fsl,drive-strength = <MXS_DRIVE_12mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				usb0_id_pins_a: usb0id at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.7.0
