From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:10 +0200
Subject: [PATCH 2/9] ARM: dts: renesas: Drop MTD partitioning from DT
In-Reply-To: <cover.1532086734.git.horms+renesas@verge.net.au>
References: <cover.1532086734.git.horms+renesas@verge.net.au>
Message-ID: <3c1b0f731777f01691bc2107aa101771b91ba509.1532086734.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Drop the MTD partitioning from DT, since it does not describe HW
and to give way to a more flexible kernel command line partition
passing.

To retain the original partitioning, assure you have enabled
CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
following to your kernel command line:

lager:   mtdparts=spi0.0:256k(loader),4m(user),-(flash)
stout:   mtdparts=spi0.0:512k(loader),256k(uboot),256k(uboot-env),-(flash)
koelsch: mtdparts=spi0.0:512k(loader),5632k(user),-(flash)
porter:  mtdparts=spi0.0:256k(loader_prg),4m(user_prg),-(flash_fs)
wheat:   mtdparts=spi0.0:256k(loader),4m(user),-(flash)
gose:    mtdparts=spi0.0:256k(loader),4m(user),-(flash)
alt:     mtdparts=spi0.0:256k(loader),256k(system),-(user)
silk:    mtdparts=spi0.0:256k(loader),4m(user),-(flash)

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> on Koelsch
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts   | 21 ---------------------
 arch/arm/boot/dts/r8a7790-stout.dts   | 26 --------------------------
 arch/arm/boot/dts/r8a7791-koelsch.dts | 21 ---------------------
 arch/arm/boot/dts/r8a7791-porter.dts  | 21 ---------------------
 arch/arm/boot/dts/r8a7792-wheat.dts   | 21 ---------------------
 arch/arm/boot/dts/r8a7793-gose.dts    | 21 ---------------------
 arch/arm/boot/dts/r8a7794-alt.dts     | 21 ---------------------
 arch/arm/boot/dts/r8a7794-silk.dts    | 21 ---------------------
 8 files changed, 173 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 092610e3f953..7c95e62efd46 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -710,27 +710,6 @@
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
 
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 8ab793d8b2fd..406d5d29e29c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -724,27 +724,6 @@
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
-				label = "user";
-				reg = <0x00080000 0x00580000>;
-				read-only;
-			};
-			partition at 600000 {
-				label = "flash";
-				reg = <0x00600000 0x03a00000>;
-			};
-		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 5f77d73d7462..e8b834e5e2bc 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -344,27 +344,6 @@
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		m25p,fast-read;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition at 0 {
-				label = "loader_prg";
-				reg = <0x00000000 0x00040000>;
-				read-only;
-			};
-			partition at 40000 {
-				label = "user_prg";
-				reg = <0x00040000 0x00400000>;
-				read-only;
-			};
-			partition at 440000 {
-				label = "flash_fs";
-				reg = <0x00440000 0x03bc0000>;
-			};
-		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/r8a7792-wheat.dts b/arch/arm/boot/dts/r8a7792-wheat.dts
index db01de7a3811..93f78716225a 100644
--- a/arch/arm/boot/dts/r8a7792-wheat.dts
+++ b/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -217,27 +217,6 @@
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
diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 7808aaee6644..b8163a0e2190 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -444,27 +444,6 @@
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
2.11.0
