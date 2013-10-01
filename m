From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 19:33:24 +0900
Subject: [PATCH 03/05] ARM: shmobile: Remove non-multiplatform KZM9D reference
 support
In-Reply-To: <20131001103255.813.65710.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
Message-ID: <20131001103324.813.82210.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when CCF is supported remove the legacy KZM9D reference
Kconfig bits CONFIG_MACH_KZM9D_REFERENCE for the non-multiplatform
case.

Starting from this commit KZM9D board support is always enabled
via CONFIG_MACH_KZM9D, and CONFIG_ARCH_MULTIPLATFORM is used
to select between board-kzm9d.c and board-kzm9d-reference.c

The file board-kzm9d-reference.c can no longer be used together
with the legacy sh-clk clock framework, instead CCF is used.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig       |   12 ------------
 arch/arm/mach-shmobile/Makefile      |    1 -
 arch/arm/mach-shmobile/Makefile.boot |    1 -
 3 files changed, 14 deletions(-)

--- 0003/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-09-27 11:25:58.000000000 +0900
@@ -226,18 +226,6 @@ config MACH_KZM9D
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
-config MACH_KZM9D_REFERENCE
-	bool "KZM9D board - Reference Device Tree Implementation"
-	depends on ARCH_EMEV2
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select USE_OF
-	---help---
-	   Use reference implementation of KZM9D board support
-	   which makes a greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
--- 0003/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-09-27 11:26:08.000000000 +0900
@@ -68,7 +68,6 @@ obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= bo
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
-obj-$(CONFIG_MACH_KZM9D_REFERENCE)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-09-27 11:26:16.000000000 +0900
@@ -8,7 +8,6 @@ loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
-loadaddr-$(CONFIG_MACH_KZM9D_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
