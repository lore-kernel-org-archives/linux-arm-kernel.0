From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Sep 2014 19:51:36 -0600
Subject: [PATCH] ARM: bcm2835: add I2S pinctrl to device tree
Message-ID: <1410918696-22696-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Florian Meier <florian.meier@koalo.de>
[Tweaked slightly to disable by default -- broonie]
Signed-off-by: Mark Brown <broonie@linaro.org>
[swarren, removed duplicate i2s node]
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
These two patches are all I expect to have for RPi for 3.18, so I figure
it's easiest to just forward them on to you rather than sending tiny pull
requests.

 arch/arm/boot/dts/bcm2835-rpi-b.dts | 8 +++++++-
 arch/arm/boot/dts/bcm2835.dtsi      | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 2a3b1c1..58a0d60 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -23,7 +23,7 @@
 
 &gpio {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gpioout &alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &alt2 &alt3>;
 
 	gpioout: gpioout {
 		brcm,pins = <6>;
@@ -39,6 +39,12 @@
 		brcm,pins = <48 49 50 51 52 53>;
 		brcm,function = <7>; /* alt3 */
 	};
+
+	/* I2S interface */
+	alt2: alt2 {
+		brcm,pins = <28 29 30 31>;
+		brcm,function = <6>; /* alt2 */
+	};
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index b8473c4..3342cb1 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -99,6 +99,7 @@
 			dmas = <&dma 2>,
 			       <&dma 3>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		spi: spi at 7e204000 {
-- 
1.9.1
