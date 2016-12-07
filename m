From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  7 Dec 2016 16:21:09 +0100
Subject: [PATCH] ARM: dts: armada-{370, xp}: drop "marvell,
 orion-spi" from SPI controllers
Message-ID: <20161207152109.17545-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

The SPI controllers on Armada 370 and XP differ from the original Orion
SPI controllers (at least) in the configuration of the baud rate. So
it's wrong to claim compatibility which results in bogus baud rates.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/armada-370.dtsi | 4 ++--
 arch/arm/boot/dts/armada-xp.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index b4258105e91f..b9377c11b379 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -435,13 +435,13 @@
  * board level if a different configuration is used.
  */
 &spi0 {
-	compatible = "marvell,armada-370-spi", "marvell,orion-spi";
+	compatible = "marvell,armada-370-spi";
 	pinctrl-0 = <&spi0_pins1>;
 	pinctrl-names = "default";
 };
 
 &spi1 {
-	compatible = "marvell,armada-370-spi", "marvell,orion-spi";
+	compatible = "marvell,armada-370-spi";
 	pinctrl-0 = <&spi1_pins>;
 	pinctrl-names = "default";
 };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 4a5f99e65b51..3a416834d80b 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -367,13 +367,13 @@
 };
 
 &spi0 {
-	compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
+	compatible = "marvell,armada-xp-spi";
 	pinctrl-0 = <&spi0_pins>;
 	pinctrl-names = "default";
 };
 
 &spi1 {
-	compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
+	compatible = "marvell,armada-xp-spi";
 	pinctrl-0 = <&spi1_pins>;
 	pinctrl-names = "default";
 };
-- 
2.10.2
