From: marex@denx.de (Marek Vasut)
Date: Tue,  2 Apr 2013 01:29:29 +0200
Subject: [PATCH] ARM: mxs: Slow down the I2C clock speed
Message-ID: <1364858969-17745-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Slow down the I2C clock speed on M28 and SPS1 as it turns out the
I2C block in i.MX28 can not operate stable enough with the bus
running at 400kHz. Note that the driver used by Freescale runs
the bus at 250kHz when 400kHz speed is selected, but the mainline
Linux kernel runs the bus at actual 400kHz and that's where it is
occasionally unstable. Play safe and run the bus at 100kHz.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-m28evk.dts |    1 -
 arch/arm/boot/dts/imx28-sps1.dts   |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 5f0ba99..5aa44e0 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -177,7 +177,6 @@
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
-				clock-frequency = <400000>;
 				status = "okay";
 
 				sgtl5000: codec at 0a {
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index e6cde8a..6c6a544 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -70,7 +70,6 @@
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
-				clock-frequency = <400000>;
 				status = "okay";
 
 				rtc: rtc at 51 {
-- 
1.7.10.4
