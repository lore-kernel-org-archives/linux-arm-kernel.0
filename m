From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 22 May 2018 14:02:51 +0200
Subject: [PATCH 3/9] ARM: dts: stout: Drop MTD partitioning from DT
In-Reply-To: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
References: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180522120257.13232-3-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the MTD partitioning from DT, since it does not describe HW
and to give way to a more flexible kernel command line partition
passing.

To retain the original partitioning, assure you have enabled
CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
following to your kernel command line:

  mtdparts=spi0.0:512k at 0(loader),256k(uboot),256k(uboot-env),-(flash)

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc at vger.kernel.org
---
 arch/arm/boot/dts/r8a7790-stout.dts | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-stout.dts b/arch/arm/boot/dts/r8a7790-stout.dts
index a13a92c26645..dc65519d53ab 100644
--- a/arch/arm/boot/dts/r8a7790-stout.dts
+++ b/arch/arm/boot/dts/r8a7790-stout.dts
@@ -211,32 +211,6 @@
 		spi-cpha;
 		spi-cpol;
 		m25p,fast-read;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition at 0 {
-				label = "loader";
-				reg = <0x00000000 0x00080000>;
-				read-only;
-			};
-			partition at 80000 {
-				label = "uboot";
-				reg = <0x00080000 0x00040000>;
-				read-only;
-			};
-			partition at c0000 {
-				label = "uboot-env";
-				reg = <0x000c0000 0x00040000>;
-				read-only;
-			};
-			partition at 100000 {
-				label = "flash";
-				reg = <0x00100000 0x03f00000>;
-			};
-		};
 	};
 };
 
-- 
2.16.2
