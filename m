From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Sep 2013 11:26:48 +0200
Subject: [PATCH] ARM: ux500: delete devices-common remnants
Message-ID: <1380187608-26492-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit f1ff5b2549990b5de080b52e3313cbb30c218853
"ARM: ux500: Stop enabling GPIOs when not booting with Device Tree"
deleted devices-common.c, but did not delete the build
rule from Makefile (most likely due to compiling in
a dirty tree where the object file still existed so
linking would complete anyway).

Delete the makerule, the header file associated
with this file and the remaining reference to the header.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile         |  3 +--
 arch/arm/mach-ux500/devices-common.h | 15 ---------------
 arch/arm/mach-ux500/devices-db8500.h |  1 -
 3 files changed, 1 insertion(+), 18 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/devices-common.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index e4ed820..616b96e 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,8 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= cpu.o devices.o devices-common.o \
-				   id.o timer.o pm.o
+obj-y				:= cpu.o devices.o id.o timer.o pm.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
deleted file mode 100644
index f3f7349..0000000
--- a/arch/arm/mach-ux500/devices-common.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-#ifndef __DEVICES_COMMON_H
-#define __DEVICES_COMMON_H
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/sys_soc.h>
-
-#endif
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 6d59218..b8ffc99 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -10,7 +10,6 @@
 
 #include "irqs.h"
 #include "db8500-regs.h"
-#include "devices-common.h"
 
 struct platform_device;
 
-- 
1.8.3.1
