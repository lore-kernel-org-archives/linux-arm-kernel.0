From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:18:13 +0900
Subject: [PATCH 09/12] ARM: shmobile: Remove non-multiplatform Koelsch
 reference support
In-Reply-To: <cover.1387891831.git.horms+renesas@verge.net.au>
References: <cover.1387891831.git.horms+renesas@verge.net.au>
Message-ID: <469cd76b53b474e3fa235656eef4257a5134b0d8.1387891831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Now that r8a7791 has CCF support remove the legacy Koelsch reference
Kconfig bits CONFIG_MACH_KOELSCH_REFERENCE for the non-multiplatform
case.

Starting from this commit Koelsch board support is always enabled via
CONFIG_MACH_KOELSCH, and CONFIG_ARCH_MULTIPLATFORM is used to select
between board-koelsch.c and board-koelsch-reference.c

The file board-koelsch-reference.c can no longer be used together with
the legacy sh-clk clock framework, instead CCF is used.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas at verge.net.au: Dropped arch/arm/boot/dts/Makefile portion]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig       | 11 -----------
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/Makefile.boot |  1 -
 3 files changed, 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 88bf980..3386406 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -268,17 +268,6 @@ config MACH_KOELSCH
 	select USE_OF
 	select MICREL_PHY if SH_ETH
 
-config MACH_KOELSCH_REFERENCE
-	bool "Koelsch board - Reference Device Tree Implementation"
-	depends on ARCH_R8A7791
-	select USE_OF
-	---help---
-	   Use reference implementation of Koelsch board support
-	   which makes use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fad94ee..fe7d4ff 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -74,7 +74,6 @@ obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
-obj-$(CONFIG_MACH_KOELSCH_REFERENCE)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index f6d5119..99455ec 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -9,7 +9,6 @@ loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_GENMAI) += 0x08008000
 loadaddr-$(CONFIG_MACH_GENMAI_REFERENCE) += 0x08008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
-loadaddr-$(CONFIG_MACH_KOELSCH_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
-- 
1.8.4
