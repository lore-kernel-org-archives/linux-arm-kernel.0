From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Thu, 16 Feb 2017 19:16:28 +0200
Subject: [PATCH] ARM: at91/dt: Disable SPI on at91sam9x5ek to allow MCI1 to
 work.
Message-ID: <1487265388-29390-1-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

The A13 hardware line is shared by SPI and MCI1 controller.This patch
disables the SPI controller so that the MCI1 (the big MMC card slot) can
be used.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 696b8ba..9d2bbc4 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -116,7 +116,7 @@
 			};
 
 			spi0: spi at f0000000 {
-				status = "okay";
+				status = "disabled"; /* conflicts with mmc1 */
 				cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
 				m25p80 at 0 {
 					compatible = "atmel,at25df321a";
-- 
2.7.4
