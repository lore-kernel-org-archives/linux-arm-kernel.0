From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Aug 2011 12:31:57 +0800
Subject: [PATCH] ARM: mmp: rename SHEEVAD to GPLUGD
Message-ID: <1313469117-7818-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GuruPlugD was initially named to be SHEEVAD, and it's causing naming
confusion in the mach-types database. Make it consistent by renaming
to GPLUGD.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/Kconfig  |    2 +-
 arch/arm/mach-mmp/Makefile |    2 +-
 arch/arm/mach-mmp/gplugd.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 56ef5f6..323d4c9 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -77,7 +77,7 @@ config MACH_TETON_BGA
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Teton BGA Development Board.
 
-config MACH_SHEEVAD
+config MACH_GPLUGD
 	bool "Marvell's PXA168 GuruPlug Display (gplugD) Board"
 	select CPU_PXA168
 	help
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 169c674..ba254a7 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -19,4 +19,4 @@ obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
 obj-$(CONFIG_MACH_TETON_BGA)	+= teton_bga.o
-obj-$(CONFIG_MACH_SHEEVAD)	+= gplugd.o
+obj-$(CONFIG_MACH_GPLUGD)	+= gplugd.o
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 98e25d9..2d2c0ad 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -188,7 +188,7 @@ static void __init gplugd_init(void)
 	pxa168_add_eth(&gplugd_eth_platform_data);
 }
 
-MACHINE_START(SHEEVAD, "PXA168-based GuruPlug Display (gplugD) Platform")
+MACHINE_START(GPLUGD, "PXA168-based GuruPlug Display (gplugD) Platform")
 	.map_io		= mmp_map_io,
 	.nr_irqs	= IRQ_BOARD_START,
 	.init_irq       = pxa168_init_irq,
-- 
1.7.4.1
