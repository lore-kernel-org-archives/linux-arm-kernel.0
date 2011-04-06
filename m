From: holler@ahsoftware.de (Alexander Holler)
Date: Wed,  6 Apr 2011 22:35:21 +0200
Subject: [PATCH 2/2] ARM: Remove machine type dockstar (use sheevaplug instead)
In-Reply-To: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1302122121-3652-3-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to have a different machine type for Seagate DockStars.
Remove it.

Be aware, this patch requires a change in the bootloader to feed the
same machine type to the kernel as used for Marvell SheevaPlugs.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/mach-kirkwood/Kconfig            |   10 ++--------
 arch/arm/mach-kirkwood/Makefile           |    1 -
 arch/arm/mach-kirkwood/sheevaplug-setup.c |   10 ----------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..9dafb58 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -27,10 +27,10 @@ config MACH_MV88F6281GTW_GE
 	  Marvell 88F6281 GTW GE Board.
 
 config MACH_SHEEVAPLUG
-	bool "Marvell SheevaPlug Reference Board"
+	bool "Marvell SheevaPlug Reference Board or Seagate DockStar"
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Marvell SheevaPlug Reference Board.
+	  Marvell SheevaPlug Reference Board or the Seagate DockStar.
 
 config MACH_ESATA_SHEEVAPLUG
 	bool "Marvell eSATA SheevaPlug Reference Board"
@@ -58,12 +58,6 @@ config MACH_TS41X
 	  QNAP TS-410, TS-410U, TS-419P, TS-419P+ and TS-419U Turbo
 	  NAS devices.
 
-config MACH_DOCKSTAR
-	bool "Seagate FreeAgent DockStar"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Seagate FreeAgent DockStar.
-
 config MACH_OPENRD
         bool
 
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index f06bc3d..48c3c83 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
-obj-$(CONFIG_MACH_DOCKSTAR)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index d1593db..f548aa9 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -177,13 +177,3 @@ MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
 	.timer		= &kirkwood_timer,
 MACHINE_END
 #endif
-
-#ifdef CONFIG_MACH_DOCKSTAR
-MACHINE_START(DOCKSTAR, "Seagate FreeAgent DockStar")
-	.boot_params	= 0x00000100,
-	.init_machine	= sheevaplug_init,
-	.map_io		= kirkwood_map_io,
-	.init_irq	= kirkwood_init_irq,
-	.timer		= &kirkwood_timer,
-MACHINE_END
-#endif
-- 
1.7.2.2
