From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 19:33:15 +0900
Subject: [PATCH 02/05] ARM: shmobile: Use KZM9D without reference for
 multiplatform
In-Reply-To: <20131001103255.813.65710.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
Message-ID: <20131001103315.813.80581.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Change the multiplatform kconfig bits for KZM9D from
CONFIG_MACH_KZM9D_REFERENCE into CONFIG_MACH_KZM9D
to match the non-multiplatform case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig  |   10 ++--------
 arch/arm/mach-shmobile/Makefile |    4 ++++
 2 files changed, 6 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-09-27 11:22:20.000000000 +0900
@@ -22,16 +22,10 @@ config ARCH_EMEV2
 
 comment "SH-Mobile Board Type"
 
-config MACH_KZM9D_REFERENCE
-	bool "KZM9D board - Reference Device Tree Implementation"
+config MACH_KZM9D
+	bool "KZM9D board"
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	---help---
-	   Use reference implementation of KZM9D board support
-	   which makes a greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
 
 comment "SH-Mobile System Configuration"
 endif
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-09-27 11:23:32.000000000 +0900
@@ -52,6 +52,9 @@ obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
+ifdef CONFIG_ARCH_SHMOBILE_MULTI
+obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
+else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
@@ -68,6 +71,7 @@ obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.
 obj-$(CONFIG_MACH_KZM9D_REFERENCE)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
+endif
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
