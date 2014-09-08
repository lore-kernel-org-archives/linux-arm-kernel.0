From: gerg@uclinux.org (gerg at uclinux.org)
Date: Mon,  8 Sep 2014 13:30:29 +1000
Subject: [PATCH] ARM: mvebu: use improved armada spi device tree compatible
 name
Message-ID: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

Switch the Armada SoC SPI port device tree binding to use the new improved
armada-370-spi compatible name. This allows for a wider range of baud rates
to be used.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 23227e0..83286ec 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -110,7 +110,7 @@
 			};
 
 			spi0: spi at 10600 {
-				compatible = "marvell,orion-spi";
+				compatible = "marvell,armada-370-spi", "marvell,orion-spi";
 				reg = <0x10600 0x28>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -121,7 +121,7 @@
 			};
 
 			spi1: spi at 10680 {
-				compatible = "marvell,orion-spi";
+				compatible = "marvell,armada-370-spi", "marvell,orion-spi";
 				reg = <0x10680 0x28>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.9.1
