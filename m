From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 24 May 2018 17:07:19 +0200
Subject: [PATCH v2 7/9] ARM: dts: gose: Drop MTD partitioning from DT
In-Reply-To: <20180524150721.28964-1-marek.vasut+renesas@gmail.com>
References: <20180524150721.28964-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180524150721.28964-7-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the MTD partitioning from DT, since it does not describe HW
and to give way to a more flexible kernel command line partition
passing.

To retain the original partitioning, assure you have enabled
CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
following to your kernel command line:

  mtdparts=spi0.0:256k(loader),4m(user),-(flash)

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc at vger.kernel.org
---
V2: Drop the @0 anchor from the commit message, use 4m
---
 arch/arm/boot/dts/r8a7793-gose.dts | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index aa209f6e5d71..b2dd54fbe40c 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -676,27 +676,6 @@
 		spi-cpol;
 		spi-cpha;
 		m25p,fast-read;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition at 0 {
-				label = "loader";
-				reg = <0x00000000 0x00040000>;
-				read-only;
-			};
-			partition at 40000 {
-				label = "user";
-				reg = <0x00040000 0x00400000>;
-				read-only;
-			};
-			partition at 440000 {
-				label = "flash";
-				reg = <0x00440000 0x03bc0000>;
-			};
-		};
 	};
 };
 
-- 
2.16.2
