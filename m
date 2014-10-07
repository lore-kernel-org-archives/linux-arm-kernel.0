From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  6 Oct 2014 21:37:42 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Let i2c0 run at 100kHz
Message-ID: <1412642262-18020-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 78b81f4666fb ("ARM: dts: imx28-evk: Run I2C0 at 400kHz") caused issues
when doing the following sequence in loop:

- Boot the kernel
- Perform audio playback
- Reboot the system via 'reboot' command

In many times the audio card cannot be probed, which causes playback to fail.

After restoring to the original i2c0 frequency of 100kHz there is no such
problem anymore.

This reverts commit 78b81f4666fbb22a20b1e63e5baf197ad2e90e88.

Cc: <stable@vger.kernel.org> # 3.16+
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e4cc44c..41a9834 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -193,7 +193,6 @@
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
-				clock-frequency = <400000>;
 				status = "okay";
 
 				sgtl5000: codec at 0a {
-- 
1.9.1
