From: mporter@konsulko.com (Matt Porter)
Date: Mon,  2 Mar 2015 13:50:06 -0500
Subject: [PATCH] ARM: dts: hummingboard: enable pcf8523 rtc for i2eX
Message-ID: <1425322206-30115-1-git-send-email-mporter@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCF8523 RTC is populated on the i2eX boards so
enable the i2c1 controller and enable the device on
that bus.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 62841e8..38ebba9 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -73,18 +73,15 @@
 };
 
 &i2c1 {
+	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hummingboard_i2c1>;
-
-	/*
-	 * Not fitted on Carrier-1 board... yet
 	status = "okay";
 
 	rtc: pcf8523 at 68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
-	 */
 };
 
 &i2c2 {
-- 
1.8.4
