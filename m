From: alexis.rodet@bvs-tech.com (Alexis RODET)
Date: Fri, 19 Nov 2010 18:23:09 +0100
Subject: [PATCH] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
In-Reply-To: <20101117160514.GA5308@n2100.arm.linux.org.uk>
References: <20101117160514.GA5308@n2100.arm.linux.org.uk>
Message-ID: <4CE6B27D.2000909@bvs-tech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> It would, however, be nice if _someone_ out there could produce a patch
Here is the patch and here is the command line used for doing this:

find . \( -name .git -prune -false -o -path \
./include/linux/spi/flash.h \ -o \( -name \*.c -execdir grep -q \
'#include <linux/spi/flash.h>' \{\} \; \) \) -execdir sed -i -e \
's/struct flash_platform_data/struct spi_flash_platform_data/' \
\{\} \+ -execdir git add \{\} \+ -print

I didn't test all compilations as I don't have blackfin compiler installed.
I compiled successfully for x86 with allyesconfig and for Freescale mx27
with allmodconfig minus some incompatible drivers.

Best regards,
Alexis RODET

---
 arch/arm/mach-at91/board-cam60.c               |    2 +-
 arch/arm/mach-at91/board-ecbat91.c             |    2 +-
 arch/arm/mach-dove/dove-db-setup.c             |    2 +-
 arch/arm/mach-kirkwood/lacie_v2-common.c       |    2 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    2 +-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    2 +-
 arch/arm/mach-kirkwood/t5325-setup.c           |    2 +-
 arch/arm/mach-kirkwood/tsx1x-common.c          |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    2 +-
 arch/arm/mach-w90x900/dev.c                    |    2 +-
 arch/blackfin/mach-bf518/boards/ezbrd.c        |    2 +-
 arch/blackfin/mach-bf518/boards/tcm-bf518.c    |    2 +-
 arch/blackfin/mach-bf527/boards/ad7160eval.c   |    2 +-
 arch/blackfin/mach-bf527/boards/cm_bf527.c     |    2 +-
 arch/blackfin/mach-bf527/boards/ezbrd.c        |    2 +-
 arch/blackfin/mach-bf527/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf527/boards/tll6527m.c     |    2 +-
 arch/blackfin/mach-bf533/boards/H8606.c        |    2 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c   |    2 +-
 arch/blackfin/mach-bf533/boards/cm_bf533.c     |    2 +-
 arch/blackfin/mach-bf533/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf533/boards/stamp.c        |    2 +-
 arch/blackfin/mach-bf537/boards/cm_bf537e.c    |    2 +-
 arch/blackfin/mach-bf537/boards/cm_bf537u.c    |    2 +-
 arch/blackfin/mach-bf537/boards/minotaur.c     |    2 +-
 arch/blackfin/mach-bf537/boards/pnav10.c       |    2 +-
 arch/blackfin/mach-bf537/boards/stamp.c        |    4 ++--
 arch/blackfin/mach-bf537/boards/tcm_bf537.c    |    2 +-
 arch/blackfin/mach-bf538/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf548/boards/cm_bf548.c     |    2 +-
 arch/blackfin/mach-bf548/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf561/boards/acvilon.c      |    2 +-
 arch/blackfin/mach-bf561/boards/cm_bf561.c     |    2 +-
 arch/mips/alchemy/devboards/db1200/platform.c  |    2 +-
 drivers/mtd/devices/m25p80.c                   |    2 +-
 drivers/mtd/devices/mtd_dataflash.c            |    2 +-
 drivers/mtd/devices/sst25l.c                   |    2 +-
 drivers/spi/spi_butterfly.c                    |    2 +-
 include/linux/spi/flash.h                      |    4 ++--
 39 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-at91/board-cam60.c
b/arch/arm/mach-at91/board-cam60.c
index b54e3e6..50780b2 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -98,7 +98,7 @@ static struct mtd_partition cam60_spi_partitions[] = {
 	},
 };
 -static struct flash_platform_data cam60_spi_flash_platform_data = {
+static struct spi_flash_platform_data cam60_spi_flash_platform_data = {
 	.name		= "spi_flash",
 	.parts		= cam60_spi_partitions,
 	.nr_parts	= ARRAY_SIZE(cam60_spi_partitions)
diff --git a/arch/arm/mach-at91/board-ecbat91.c
b/arch/arm/mach-at91/board-ecbat91.c
index 7b58c94..8598237 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -110,7 +110,7 @@ static struct mtd_partition __initdata
my_flash0_partitions[] =
 	}
 };
 -static struct flash_platform_data __initdata my_flash0_platform = {
+static struct spi_flash_platform_data __initdata my_flash0_platform = {
 	.name		= "Removable flash card",
 	.parts		= my_flash0_partitions,
 	.nr_parts	= ARRAY_SIZE(my_flash0_partitions)
diff --git a/arch/arm/mach-dove/dove-db-setup.c
b/arch/arm/mach-dove/dove-db-setup.c
index 95925aa..90f8f95 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -40,7 +40,7 @@ static struct mv_sata_platform_data dove_db_sata_data = {
  * SPI Devices:
  * 	SPI0: 4M Flash ST-M25P32-VMF6P

****************************************************************************/
-static const struct flash_platform_data dove_db_spi_flash_data = {
+static const struct spi_flash_platform_data dove_db_spi_flash_data = {
 	.type		= "m25p64",
 };
 diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.c
b/arch/arm/mach-kirkwood/lacie_v2-common.c
index 285edab..b60003f 100644
--- a/arch/arm/mach-kirkwood/lacie_v2-common.c
+++ b/arch/arm/mach-kirkwood/lacie_v2-common.c
@@ -33,7 +33,7 @@ static struct mtd_partition lacie_v2_flash_parts[] = {
 	},
 };
 -static const struct flash_platform_data lacie_v2_flash = {
+static const struct spi_flash_platform_data lacie_v2_flash = {
 	.type		= "mx25l4005a",
 	.name		= "spi_flash",
 	.parts		= lacie_v2_flash_parts,
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 1e5266f..16356c8 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -52,7 +52,7 @@ static struct dsa_platform_data
mv88f6281gtw_ge_switch_plat_data = {
 	.chip		= &mv88f6281gtw_ge_switch_chip_data,
 };
 -static const struct flash_platform_data mv88f6281gtw_ge_spi_slave_data = {
+static const struct spi_flash_platform_data
mv88f6281gtw_ge_spi_slave_data = {
 	.type		= "mx25l12805d",
 };
 diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index 0049614..d3b706f 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -32,7 +32,7 @@ static struct mv_sata_platform_data
rd88f6192_sata_data = {
 	.n_ports	= 2,
 };
 -static const struct flash_platform_data rd88F6192_spi_slave_data = {
+static const struct spi_flash_platform_data rd88F6192_spi_slave_data = {
 	.type		= "m25p128",
 };
 diff --git a/arch/arm/mach-kirkwood/t5325-setup.c
b/arch/arm/mach-kirkwood/t5325-setup.c
index ce50e61..d086983 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-kirkwood/t5325-setup.c
@@ -59,7 +59,7 @@ struct mtd_partition hp_t5325_partitions[] = {
 	},
 };
 -const struct flash_platform_data hp_t5325_flash = {
+const struct spi_flash_platform_data hp_t5325_flash = {
 	.type		= "mx25l8005",
 	.name		= "spi_flash",
 	.parts		= hp_t5325_partitions,
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.c
b/arch/arm/mach-kirkwood/tsx1x-common.c
index f781164..14c7825 100644
--- a/arch/arm/mach-kirkwood/tsx1x-common.c
+++ b/arch/arm/mach-kirkwood/tsx1x-common.c
@@ -59,7 +59,7 @@ struct mtd_partition qnap_tsx1x_partitions[] = {
 	},
 };
 -const struct flash_platform_data qnap_tsx1x_flash = {
+const struct spi_flash_platform_data qnap_tsx1x_flash = {
 	.type		= "m25p128",
 	.name		= "spi_flash",
 	.parts		= qnap_tsx1x_partitions,
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 02ff45f..b18bb24 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -65,7 +65,7 @@ static struct mtd_partition
rd88f6183ap_ge_partitions[] = {
 	},
 };
 -static struct flash_platform_data rd88f6183ap_ge_spi_slave_data = {
+static struct spi_flash_platform_data rd88f6183ap_ge_spi_slave_data = {
 	.type		= "m25p64",
 	.nr_parts	= ARRAY_SIZE(rd88f6183ap_ge_partitions),
 	.parts		= rd88f6183ap_ge_partitions,
diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 7a1fa6a..12d7f7c 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -246,7 +246,7 @@ static struct mtd_partition
nuc900_spi_flash_partitions[] = {
 	},
 };
 -static struct flash_platform_data nuc900_spi_flash_data = {
+static struct spi_flash_platform_data nuc900_spi_flash_data = {
 	.name = "m25p80",
 	.parts =  nuc900_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(nuc900_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf518/boards/ezbrd.c
b/arch/blackfin/mach-bf518/boards/ezbrd.c
index b894c8a..ded02c1 100644
--- a/arch/blackfin/mach-bf518/boards/ezbrd.c
+++ b/arch/blackfin/mach-bf518/boards/ezbrd.c
@@ -178,7 +178,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf518/boards/tcm-bf518.c
b/arch/blackfin/mach-bf518/boards/tcm-bf518.c
index e6ce1d7..66817b0 100644
--- a/arch/blackfin/mach-bf518/boards/tcm-bf518.c
+++ b/arch/blackfin/mach-bf518/boards/tcm-bf518.c
@@ -128,7 +128,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c
b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index fc767ac..c43724b 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -254,7 +254,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/cm_bf527.c
b/arch/blackfin/mach-bf527/boards/cm_bf527.c
index 2c31af7..3d5a3dc 100644
--- a/arch/blackfin/mach-bf527/boards/cm_bf527.c
+++ b/arch/blackfin/mach-bf527/boards/cm_bf527.c
@@ -341,7 +341,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/ezbrd.c
b/arch/blackfin/mach-bf527/boards/ezbrd.c
index 9a736a8..6670939 100644
--- a/arch/blackfin/mach-bf527/boards/ezbrd.c
+++ b/arch/blackfin/mach-bf527/boards/ezbrd.c
@@ -240,7 +240,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c
b/arch/blackfin/mach-bf527/boards/ezkit.c
index 9222bc0..78a07e7 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -434,7 +434,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/tll6527m.c
b/arch/blackfin/mach-bf527/boards/tll6527m.c
index 9ec5757..147374b 100644
--- a/arch/blackfin/mach-bf527/boards/tll6527m.c
+++ b/arch/blackfin/mach-bf527/boards/tll6527m.c
@@ -304,7 +304,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/H8606.c
b/arch/blackfin/mach-bf533/boards/H8606.c
index 2ce7b16..60ff37f 100644
--- a/arch/blackfin/mach-bf533/boards/H8606.c
+++ b/arch/blackfin/mach-bf533/boards/H8606.c
@@ -149,7 +149,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/blackstamp.c
b/arch/blackfin/mach-bf533/boards/blackstamp.c
index 20c1022..cbdcca1 100644
--- a/arch/blackfin/mach-bf533/boards/blackstamp.c
+++ b/arch/blackfin/mach-bf533/boards/blackstamp.c
@@ -93,7 +93,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/cm_bf533.c
b/arch/blackfin/mach-bf533/boards/cm_bf533.c
index adbe62a..6448686 100644
--- a/arch/blackfin/mach-bf533/boards/cm_bf533.c
+++ b/arch/blackfin/mach-bf533/boards/cm_bf533.c
@@ -49,7 +49,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c
b/arch/blackfin/mach-bf533/boards/ezkit.c
index a1cb8e7..4e1ee73 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -200,7 +200,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c
b/arch/blackfin/mach-bf533/boards/stamp.c
index b3b1cde..8554b38 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -163,7 +163,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537e.c
b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
index 836698c..c1bb193 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537e.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
@@ -51,7 +51,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537u.c
b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
index 2a85670..da1886e 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537u.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
@@ -52,7 +52,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/minotaur.c
b/arch/blackfin/mach-bf537/boards/minotaur.c
index 4980051..c360f10 100644
--- a/arch/blackfin/mach-bf537/boards/minotaur.c
+++ b/arch/blackfin/mach-bf537/boards/minotaur.c
@@ -149,7 +149,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/pnav10.c
b/arch/blackfin/mach-bf537/boards/pnav10.c
index b958078..aab7edd 100644
--- a/arch/blackfin/mach-bf537/boards/pnav10.c
+++ b/arch/blackfin/mach-bf537/boards/pnav10.c
@@ -174,7 +174,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c
b/arch/blackfin/mach-bf537/boards/stamp.c
index 3aa344c..633cbf0 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -526,7 +526,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
@@ -1003,7 +1003,7 @@ static struct mtd_partition
bfin_spi_dataflash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_dataflash_data = {
+static struct spi_flash_platform_data bfin_spi_dataflash_data = {
 	.name = "SPI Dataflash",
 	.parts = bfin_spi_dataflash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_dataflash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/tcm_bf537.c
b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
index 31498ad..557747f 100644
--- a/arch/blackfin/mach-bf537/boards/tcm_bf537.c
+++ b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
@@ -52,7 +52,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf538/boards/ezkit.c
b/arch/blackfin/mach-bf538/boards/ezkit.c
index c6fb0a5..de9ab68 100644
--- a/arch/blackfin/mach-bf538/boards/ezkit.c
+++ b/arch/blackfin/mach-bf538/boards/ezkit.c
@@ -493,7 +493,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf548/boards/cm_bf548.c
b/arch/blackfin/mach-bf548/boards/cm_bf548.c
index f0c0eef..7effe25 100644
--- a/arch/blackfin/mach-bf548/boards/cm_bf548.c
+++ b/arch/blackfin/mach-bf548/boards/cm_bf548.c
@@ -849,7 +849,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c
b/arch/blackfin/mach-bf548/boards/ezkit.c
index 216e269..1ab35e3 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -957,7 +957,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c
b/arch/blackfin/mach-bf561/boards/acvilon.c
index 0b1c20f..7f69032 100644
--- a/arch/blackfin/mach-bf561/boards/acvilon.c
+++ b/arch/blackfin/mach-bf561/boards/acvilon.c
@@ -359,7 +359,7 @@ static struct mtd_partition
bfin_spi_dataflash_partitions[] = {
 	 }
 };
 -static struct flash_platform_data bfin_spi_dataflash_data = {
+static struct spi_flash_platform_data bfin_spi_dataflash_data = {
 	.name = "SPI Dataflash",
 	.parts = bfin_spi_dataflash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_dataflash_partitions),
diff --git a/arch/blackfin/mach-bf561/boards/cm_bf561.c
b/arch/blackfin/mach-bf561/boards/cm_bf561.c
index 087b6b0..80073ac 100644
--- a/arch/blackfin/mach-bf561/boards/cm_bf561.c
+++ b/arch/blackfin/mach-bf561/boards/cm_bf561.c
@@ -50,7 +50,7 @@ static struct mtd_partition
bfin_spi_flash_partitions[] = {
 	}
 };
 -static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c
b/arch/mips/alchemy/devboards/db1200/platform.c
index fbb5593..ea9bf90 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -50,7 +50,7 @@ static struct mtd_partition db1200_spiflash_parts[] = {
 	},
 };
 -static struct flash_platform_data db1200_spiflash_data = {
+static struct spi_flash_platform_data db1200_spiflash_data = {
 	.name		= "s25fl001",
 	.parts		= db1200_spiflash_parts,
 	.nr_parts	= ARRAY_SIZE(db1200_spiflash_parts),
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index bf5a002..4244468 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -776,7 +776,7 @@ static const struct spi_device_id *__devinit
jedec_probe(struct spi_device *spi)
 static int __devinit m25p_probe(struct spi_device *spi)
 {
 	const struct spi_device_id	*id = spi_get_device_id(spi);
-	struct flash_platform_data	*data;
+	struct spi_flash_platform_data	*data;
 	struct m25p			*flash;
 	struct flash_info		*info;
 	unsigned			i;
diff --git a/drivers/mtd/devices/mtd_dataflash.c
b/drivers/mtd/devices/mtd_dataflash.c
index c5015cc..9cb2727 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -634,7 +634,7 @@ add_dataflash_otp(struct spi_device *spi, char *name,
 {
 	struct dataflash		*priv;
 	struct mtd_info			*device;
-	struct flash_platform_data	*pdata = spi->dev.platform_data;
+	struct spi_flash_platform_data	*pdata = spi->dev.platform_data;
 	char				*otp_tag = "";
 	int				err = 0;
 diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index 684247a..989758d 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -379,7 +379,7 @@ static int __init sst25l_probe(struct spi_device *spi)
 {
 	struct flash_info *flash_info;
 	struct sst25l_flash *flash;
-	struct flash_platform_data *data;
+	struct spi_flash_platform_data *data;
 	int ret, i;
  	flash_info = sst25l_match_device(spi);
diff --git a/drivers/spi/spi_butterfly.c b/drivers/spi/spi_butterfly.c
index 0d4ceba..a9ac6b2 100644
--- a/drivers/spi/spi_butterfly.c
+++ b/drivers/spi/spi_butterfly.c
@@ -183,7 +183,7 @@ static struct mtd_partition partitions[] = { {
 	.size		= MTDPART_SIZ_FULL,
 } };
 -static struct flash_platform_data flash = {
+static struct spi_flash_platform_data flash = {
 	.name		= "butterflash",
 	.parts		= partitions,
 	.nr_parts	= ARRAY_SIZE(partitions),
diff --git a/include/linux/spi/flash.h b/include/linux/spi/flash.h
index 3f22932..946145e 100644
--- a/include/linux/spi/flash.h
+++ b/include/linux/spi/flash.h
@@ -4,7 +4,7 @@
 struct mtd_partition;
  /**
- * struct flash_platform_data: board-specific flash data
+ * struct spi_flash_platform_data: board-specific flash data
  * @name: optional flash device name (eg, as used with mtdparts=)
  * @parts: optional array of mtd_partitions for static partitioning
  * @nr_parts: number of mtd_partitions for static partitoning
@@ -18,7 +18,7 @@ struct mtd_partition;
  * Note that for DataFlash, sizes for pages, blocks, and sectors are
  * rarely powers of two; and partitions should be sector-aligned.
  */
-struct flash_platform_data {
+struct spi_flash_platform_data {
 	char		*name;
 	struct mtd_partition *parts;
 	unsigned int	nr_parts;
-- 
1.7.1
