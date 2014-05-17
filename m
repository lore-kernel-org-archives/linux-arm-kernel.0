From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 May 2014 10:24:50 +0900
Subject: [PATCH 1/5] ARM: shmobile: Remove non-multiplatform Genmai reference
 support
In-Reply-To: <cover.1400289483.git.horms+renesas@verge.net.au>
References: <cover.1400289483.git.horms+renesas@verge.net.au>
Message-ID: <551f80a5c915c4615cd4065ad4db5cf68f765b97.1400289483.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Now that r7s72100 has CCF support, remove the legacy Genmai reference
Kconfig bits for the non-multiplatform case.

Starting from this commit Genmai board support is always enabled via
CONFIG_MACH_GENMAI, and CONFIG_ARCH_MULTIPLATFORM is used to select
between board-genmai.c and board-genmai-reference.c

The file board-genmai-reference.c can no longer be used together with
the legacy sh-clk clock framework, instead CCF is used.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile           |  1 -
 arch/arm/mach-shmobile/Kconfig       | 11 -----------
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/Makefile.boot |  1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35c146f..4ede75e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -306,7 +306,6 @@ dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
 	s3c6410-smdk6410.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
-	r7s72100-genmai-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0f92ba8..2ba18c6 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -240,17 +240,6 @@ config MACH_GENMAI
 	depends on ARCH_R7S72100
 	select USE_OF
 
-config MACH_GENMAI_REFERENCE
-	bool "Genmai board - Reference Device Tree Implementation"
-	depends on ARCH_R7S72100
-	select USE_OF
-	---help---
-	   Use reference implementation of Genmai board support
-	   which makes use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index c12a1c5..a455584 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -67,7 +67,6 @@ obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
-obj-$(CONFIG_MACH_GENMAI_REFERENCE)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 99455ec..918fccf 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -7,7 +7,6 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_GENMAI) += 0x08008000
-loadaddr-$(CONFIG_MACH_GENMAI_REFERENCE) += 0x08008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
-- 
1.8.4
