From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:50 +0000
Subject: [PATCH 07/13] ARM: spear: move all files to mach-spear
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no conflicting files between the three mach-spear* directories
and plat-spear any more, so we can now move all file to a common
mach-spear directory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                   |  2 +-
 arch/arm/Makefile                                  |  5 +----
 arch/arm/{plat-spear => mach-spear}/Kconfig        |  0
 arch/arm/mach-spear/Makefile                       | 22 ++++++++++++++++++++++
 .../{mach-spear13xx => mach-spear}/Makefile.boot   |  0
 arch/arm/{mach-spear13xx => mach-spear}/headsmp.S  |  0
 arch/arm/{mach-spear13xx => mach-spear}/hotplug.c  |  0
 .../include/mach/debug-macro.S                     |  0
 .../include/mach/generic.h                         |  0
 .../include/mach/hardware.h                        |  0
 .../{plat-spear => mach-spear}/include/mach/irqs.h |  0
 .../include/mach/misc_regs.h                       |  0
 .../include/mach/spear.h                           |  0
 .../include/mach/timex.h                           |  0
 .../include/mach/uncompress.h                      |  0
 .../include/plat/pl080.h                           |  0
 arch/arm/{plat-spear => mach-spear}/pl080.c        |  0
 arch/arm/{mach-spear13xx => mach-spear}/platsmp.c  |  0
 arch/arm/{plat-spear => mach-spear}/restart.c      |  0
 .../arm/{mach-spear13xx => mach-spear}/spear1310.c |  0
 .../arm/{mach-spear13xx => mach-spear}/spear1340.c |  0
 .../{mach-spear13xx => mach-spear}/spear13xx-dma.h |  0
 .../arm/{mach-spear13xx => mach-spear}/spear13xx.c |  0
 arch/arm/{mach-spear3xx => mach-spear}/spear300.c  |  0
 arch/arm/{mach-spear3xx => mach-spear}/spear310.c  |  0
 arch/arm/{mach-spear3xx => mach-spear}/spear320.c  |  0
 arch/arm/{mach-spear3xx => mach-spear}/spear3xx.c  |  0
 arch/arm/{mach-spear6xx => mach-spear}/spear6xx.c  |  0
 arch/arm/{plat-spear => mach-spear}/time.c         |  0
 arch/arm/mach-spear13xx/Makefile                   | 10 ----------
 arch/arm/mach-spear3xx/Makefile                    | 15 ---------------
 arch/arm/mach-spear3xx/Makefile.boot               |  3 ---
 arch/arm/mach-spear6xx/Makefile                    |  6 ------
 arch/arm/mach-spear6xx/Makefile.boot               |  3 ---
 arch/arm/plat-spear/Makefile                       |  9 ---------
 35 files changed, 24 insertions(+), 51 deletions(-)
 rename arch/arm/{plat-spear => mach-spear}/Kconfig (100%)
 create mode 100644 arch/arm/mach-spear/Makefile
 rename arch/arm/{mach-spear13xx => mach-spear}/Makefile.boot (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/headsmp.S (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/hotplug.c (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/debug-macro.S (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/generic.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/hardware.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/irqs.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/misc_regs.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/spear.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/timex.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/mach/uncompress.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/include/plat/pl080.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/pl080.c (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/platsmp.c (100%)
 rename arch/arm/{plat-spear => mach-spear}/restart.c (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/spear1310.c (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/spear1340.c (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/spear13xx-dma.h (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/spear13xx.c (100%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear300.c (100%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear310.c (100%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear320.c (100%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear3xx.c (100%)
 rename arch/arm/{mach-spear6xx => mach-spear}/spear6xx.c (100%)
 rename arch/arm/{plat-spear => mach-spear}/time.c (100%)
 delete mode 100644 arch/arm/mach-spear13xx/Makefile
 delete mode 100644 arch/arm/mach-spear3xx/Makefile
 delete mode 100644 arch/arm/mach-spear3xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear6xx/Makefile
 delete mode 100644 arch/arm/mach-spear6xx/Makefile.boot
 delete mode 100644 arch/arm/plat-spear/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..1b5ad03 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1090,7 +1090,7 @@ source "arch/arm/plat-s3c24xx/Kconfig"
 
 source "arch/arm/mach-socfpga/Kconfig"
 
-source "arch/arm/plat-spear/Kconfig"
+source "arch/arm/mach-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
 if ARCH_S3C24XX
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30c443c..8969998 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -191,9 +191,7 @@ machine-$(CONFIG_ARCH_VT8500)		+= vt8500
 machine-$(CONFIG_ARCH_W90X900)		+= w90x900
 machine-$(CONFIG_FOOTBRIDGE)		+= footbridge
 machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
-machine-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx
-machine-$(CONFIG_ARCH_SPEAR3XX)		+= spear3xx
-machine-$(CONFIG_MACH_SPEAR600)		+= spear6xx
+machine-$(CONFIG_PLAT_SPEAR)		+= spear
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 
@@ -206,7 +204,6 @@ plat-$(CONFIG_PLAT_ORION)	+= orion
 plat-$(CONFIG_PLAT_PXA)		+= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	+= s3c24xx samsung
 plat-$(CONFIG_PLAT_S5P)		+= samsung
-plat-$(CONFIG_PLAT_SPEAR)	+= spear
 plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/mach-spear/Kconfig
similarity index 100%
rename from arch/arm/plat-spear/Kconfig
rename to arch/arm/mach-spear/Kconfig
diff --git a/arch/arm/mach-spear/Makefile b/arch/arm/mach-spear/Makefile
new file mode 100644
index 0000000..8a937bf
--- /dev/null
+++ b/arch/arm/mach-spear/Makefile
@@ -0,0 +1,22 @@
+#
+# SPEAr Platform specific Makefile
+#
+
+# Common support
+obj-y	:= restart.o time.o
+
+obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+
+obj-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx.o
+obj-$(CONFIG_MACH_SPEAR1310)	+= spear1310.o
+obj-$(CONFIG_MACH_SPEAR1340)	+= spear1340.o
+
+obj-$(CONFIG_ARCH_SPEAR3XX)	+= spear3xx.o
+obj-$(CONFIG_ARCH_SPEAR3XX)	+= pl080.o
+obj-$(CONFIG_MACH_SPEAR300)	+= spear300.o
+obj-$(CONFIG_MACH_SPEAR310)	+= spear310.o
+obj-$(CONFIG_MACH_SPEAR320)	+= spear320.o
+
+obj-$(CONFIG_ARCH_SPEAR6XX)	+= spear6xx.o
+obj-$(CONFIG_ARCH_SPEAR6XX)	+= pl080.o
diff --git a/arch/arm/mach-spear13xx/Makefile.boot b/arch/arm/mach-spear/Makefile.boot
similarity index 100%
rename from arch/arm/mach-spear13xx/Makefile.boot
rename to arch/arm/mach-spear/Makefile.boot
diff --git a/arch/arm/mach-spear13xx/headsmp.S b/arch/arm/mach-spear/headsmp.S
similarity index 100%
rename from arch/arm/mach-spear13xx/headsmp.S
rename to arch/arm/mach-spear/headsmp.S
diff --git a/arch/arm/mach-spear13xx/hotplug.c b/arch/arm/mach-spear/hotplug.c
similarity index 100%
rename from arch/arm/mach-spear13xx/hotplug.c
rename to arch/arm/mach-spear/hotplug.c
diff --git a/arch/arm/plat-spear/include/mach/debug-macro.S b/arch/arm/mach-spear/include/mach/debug-macro.S
similarity index 100%
rename from arch/arm/plat-spear/include/mach/debug-macro.S
rename to arch/arm/mach-spear/include/mach/debug-macro.S
diff --git a/arch/arm/plat-spear/include/mach/generic.h b/arch/arm/mach-spear/include/mach/generic.h
similarity index 100%
rename from arch/arm/plat-spear/include/mach/generic.h
rename to arch/arm/mach-spear/include/mach/generic.h
diff --git a/arch/arm/plat-spear/include/mach/hardware.h b/arch/arm/mach-spear/include/mach/hardware.h
similarity index 100%
rename from arch/arm/plat-spear/include/mach/hardware.h
rename to arch/arm/mach-spear/include/mach/hardware.h
diff --git a/arch/arm/plat-spear/include/mach/irqs.h b/arch/arm/mach-spear/include/mach/irqs.h
similarity index 100%
rename from arch/arm/plat-spear/include/mach/irqs.h
rename to arch/arm/mach-spear/include/mach/irqs.h
diff --git a/arch/arm/plat-spear/include/mach/misc_regs.h b/arch/arm/mach-spear/include/mach/misc_regs.h
similarity index 100%
rename from arch/arm/plat-spear/include/mach/misc_regs.h
rename to arch/arm/mach-spear/include/mach/misc_regs.h
diff --git a/arch/arm/plat-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
similarity index 100%
rename from arch/arm/plat-spear/include/mach/spear.h
rename to arch/arm/mach-spear/include/mach/spear.h
diff --git a/arch/arm/plat-spear/include/mach/timex.h b/arch/arm/mach-spear/include/mach/timex.h
similarity index 100%
rename from arch/arm/plat-spear/include/mach/timex.h
rename to arch/arm/mach-spear/include/mach/timex.h
diff --git a/arch/arm/plat-spear/include/mach/uncompress.h b/arch/arm/mach-spear/include/mach/uncompress.h
similarity index 100%
rename from arch/arm/plat-spear/include/mach/uncompress.h
rename to arch/arm/mach-spear/include/mach/uncompress.h
diff --git a/arch/arm/plat-spear/include/plat/pl080.h b/arch/arm/mach-spear/include/plat/pl080.h
similarity index 100%
rename from arch/arm/plat-spear/include/plat/pl080.h
rename to arch/arm/mach-spear/include/plat/pl080.h
diff --git a/arch/arm/plat-spear/pl080.c b/arch/arm/mach-spear/pl080.c
similarity index 100%
rename from arch/arm/plat-spear/pl080.c
rename to arch/arm/mach-spear/pl080.c
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear/platsmp.c
similarity index 100%
rename from arch/arm/mach-spear13xx/platsmp.c
rename to arch/arm/mach-spear/platsmp.c
diff --git a/arch/arm/plat-spear/restart.c b/arch/arm/mach-spear/restart.c
similarity index 100%
rename from arch/arm/plat-spear/restart.c
rename to arch/arm/mach-spear/restart.c
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear/spear1310.c
similarity index 100%
rename from arch/arm/mach-spear13xx/spear1310.c
rename to arch/arm/mach-spear/spear1310.c
diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear/spear1340.c
similarity index 100%
rename from arch/arm/mach-spear13xx/spear1340.c
rename to arch/arm/mach-spear/spear1340.c
diff --git a/arch/arm/mach-spear13xx/spear13xx-dma.h b/arch/arm/mach-spear/spear13xx-dma.h
similarity index 100%
rename from arch/arm/mach-spear13xx/spear13xx-dma.h
rename to arch/arm/mach-spear/spear13xx-dma.h
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
similarity index 100%
rename from arch/arm/mach-spear13xx/spear13xx.c
rename to arch/arm/mach-spear/spear13xx.c
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear/spear300.c
similarity index 100%
rename from arch/arm/mach-spear3xx/spear300.c
rename to arch/arm/mach-spear/spear300.c
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear/spear310.c
similarity index 100%
rename from arch/arm/mach-spear3xx/spear310.c
rename to arch/arm/mach-spear/spear310.c
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear/spear320.c
similarity index 100%
rename from arch/arm/mach-spear3xx/spear320.c
rename to arch/arm/mach-spear/spear320.c
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
similarity index 100%
rename from arch/arm/mach-spear3xx/spear3xx.c
rename to arch/arm/mach-spear/spear3xx.c
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
similarity index 100%
rename from arch/arm/mach-spear6xx/spear6xx.c
rename to arch/arm/mach-spear/spear6xx.c
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/mach-spear/time.c
similarity index 100%
rename from arch/arm/plat-spear/time.c
rename to arch/arm/mach-spear/time.c
diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
deleted file mode 100644
index 3435ea7..0000000
--- a/arch/arm/mach-spear13xx/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for SPEAr13XX machine series
-#
-
-obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-
-obj-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx.o
-obj-$(CONFIG_MACH_SPEAR1310)	+= spear1310.o
-obj-$(CONFIG_MACH_SPEAR1340)	+= spear1340.o
diff --git a/arch/arm/mach-spear3xx/Makefile b/arch/arm/mach-spear3xx/Makefile
deleted file mode 100644
index 8d12faa..0000000
--- a/arch/arm/mach-spear3xx/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# Makefile for SPEAr3XX machine series
-#
-
-# common files
-obj-$(CONFIG_ARCH_SPEAR3XX)	+= spear3xx.o
-
-# spear300 specific files
-obj-$(CONFIG_MACH_SPEAR300) += spear300.o
-
-# spear310 specific files
-obj-$(CONFIG_MACH_SPEAR310) += spear310.o
-
-# spear320 specific files
-obj-$(CONFIG_MACH_SPEAR320) += spear320.o
diff --git a/arch/arm/mach-spear3xx/Makefile.boot b/arch/arm/mach-spear3xx/Makefile.boot
deleted file mode 100644
index 4674a4c..0000000
--- a/arch/arm/mach-spear3xx/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-spear6xx/Makefile b/arch/arm/mach-spear6xx/Makefile
deleted file mode 100644
index 898831d..0000000
--- a/arch/arm/mach-spear6xx/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-#
-# Makefile for SPEAr6XX machine series
-#
-
-# common files
-obj-y	+= spear6xx.o
diff --git a/arch/arm/mach-spear6xx/Makefile.boot b/arch/arm/mach-spear6xx/Makefile.boot
deleted file mode 100644
index 4674a4c..0000000
--- a/arch/arm/mach-spear6xx/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
deleted file mode 100644
index 01e8853..0000000
--- a/arch/arm/plat-spear/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# SPEAr Platform specific Makefile
-#
-
-# Common support
-obj-y	:= restart.o time.o
-
-obj-$(CONFIG_ARCH_SPEAR3XX)	+= pl080.o
-obj-$(CONFIG_ARCH_SPEAR6XX)	+= pl080.o
-- 
1.8.0
