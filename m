From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 15 Oct 2014 09:39:53 -0700
Subject: [PATCH] ARM: zynq: Actually remove hotplug.c
Message-ID: <1413391193-26710-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 'ARM: zynq: Remove hotplug.c'
(caf86a73eab4132f870e883216850d9eee40b04b) was supposed to remove
hotplug.c - but it didn't. It moved all content from
hotplug.c elsewhere and removed its entry from the Makefile, but missed
to actually remove the whole file. Remove it now.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/Makefile  |  2 --
 arch/arm/mach-zynq/hotplug.c | 14 --------------
 2 files changed, 16 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/hotplug.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index c85fb3f7d5cd..b03a97eb7501 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -4,6 +4,4 @@
 
 # Common support
 obj-y				:= common.o slcr.o pm.o
-CFLAGS_REMOVE_hotplug.o		=-march=armv6k
-CFLAGS_hotplug.o 		=-Wa,-march=armv7-a -mcpu=cortex-a9
 obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o
diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
deleted file mode 100644
index b685c89f11e4..000000000000
--- a/arch/arm/mach-zynq/hotplug.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright (C) 2012-2013 Xilinx
- *
- * based on linux/arch/arm/mach-realview/hotplug.c
- *
- * Copyright (C) 2002 ARM Ltd.
- * All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/proc-fns.h>
-
-- 
2.1.2.1.g5e69ed6
