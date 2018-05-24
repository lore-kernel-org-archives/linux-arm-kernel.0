From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 24 May 2018 17:07:20 +0200
Subject: [PATCH v2 8/9] ARM: dts: alt: Drop MTD partitioning from DT
In-Reply-To: <20180524150721.28964-1-marek.vasut+renesas@gmail.com>
References: <20180524150721.28964-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180524150721.28964-8-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the MTD partitioning from DT, since it does not describe HW
and to give way to a more flexible kernel command line partition
passing.

To retain the original partitioning, assure you have enabled
CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
following to your kernel command line:

  mtdparts=spi0.0:256k(loader),256k(system),-(user)

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc at vger.kernel.org
---
V2: Drop the @0 anchor from the commit message
---
 arch/arm/boot/dts/r8a7794-alt.dts | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index e17027532941..1d044ed598f3 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -419,26 +419,5 @@
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
-				label = "system";
-				reg = <0x00040000 0x00040000>;
-				read-only;
-			};
-			partition at 80000 {
-				label = "user";
-				reg = <0x00080000 0x03f80000>;
-			};
-		};
 	};
 };
-- 
2.16.2
