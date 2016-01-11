From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Jan 2016 13:33:01 +0900
Subject: [PATCH 5/6] ARM: dts: gose: Add compatible property to "partitions"
 node
In-Reply-To: <cover.1452486598.git.horms+renesas@verge.net.au>
References: <cover.1452486598.git.horms+renesas@verge.net.au>
Message-ID: <e5e6f9b4891af3617a76f5220f1efaf365f837da.1452486598.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7793-gose.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 3e3122490650..baa59fe84298 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -115,6 +115,7 @@
 		m25p,fast-read;
 
 		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.7.0.rc3.207.g0ac5344
