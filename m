From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Nov 2013 15:47:39 -0200
Subject: [PATCH] ARM: dts: imx28-evk: Run I2C0 at 400kHz
Message-ID: <1385401659-22751-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is safe to operate I2C0 at 400kHz as SGTL5000 supports this frequency.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 41a9834..e4cc44c 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -193,6 +193,7 @@
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
+				clock-frequency = <400000>;
 				status = "okay";
 
 				sgtl5000: codec at 0a {
-- 
1.8.1.2
