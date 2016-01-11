From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Jan 2016 13:33:02 +0900
Subject: [PATCH 6/6] ARM: dts: silk: Add compatible property to "partitions"
 node
In-Reply-To: <cover.1452486598.git.horms+renesas@verge.net.au>
References: <cover.1452486598.git.horms+renesas@verge.net.au>
Message-ID: <8bc403b78ffb774d8dc944abb0826c46c0dca09d.1452486598.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 5a8dcac37c8e..5153e3af25d9 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -204,6 +204,7 @@
 		m25p,fast-read;
 
 		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.7.0.rc3.207.g0ac5344
