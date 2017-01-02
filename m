From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 14:55:32 +0000
Subject: [PATCH] ARM: dts: armada388-clearfog: fix SPI flash #size-cells
Message-ID: <E1cO41M-0007xc-Id@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI flash #size-cells is specified in the binding documentation to
have value 1, but we were setting it to zero.  This wasn't causing any
problem as we do not list any partitions, but it's worth specifying
correctly if we're going to specify it at all.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 71ce201c903e..3e7c3a6237c3 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -437,7 +437,7 @@
 
 	spi-flash at 0 {
 		#address-cells = <1>;
-		#size-cells = <0>;
+		#size-cells = <1>;
 		compatible = "w25q32", "jedec,spi-nor";
 		reg = <0>; /* Chip select 0 */
 		spi-max-frequency = <3000000>;
-- 
2.7.4
