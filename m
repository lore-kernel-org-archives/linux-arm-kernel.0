From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 29 Jan 2017 21:53:10 +0200
Subject: [PATCH 1/2] ARM: bcm2835: dts: fix i2c0 pins
Message-ID: <9290fa9eed6b5ff1c5c96b9dac41eca286b7eef9.1485719591.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the BCM2835 ARM Peripherals document i2c0 doesn't map to pins 32,
34 but to 28, 29.

Fixes: 21ff843931b ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index bc8ad417c8a3..2ae842921250 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -195,8 +195,8 @@
 				brcm,pins = <0 1>;
 				brcm,function = <BCM2835_FSEL_ALT0>;
 			};
-			i2c0_gpio32: i2c0_gpio32 {
-				brcm,pins = <32 34>;
+			i2c0_gpio28: i2c0_gpio28 {
+				brcm,pins = <28 29>;
 				brcm,function = <BCM2835_FSEL_ALT0>;
 			};
 			i2c0_gpio44: i2c0_gpio44 {
-- 
2.11.0
