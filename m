From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 16:35:08 +0900
Subject: [PATCH] ARM: shmobile: Remove EMEV2 header file
Message-ID: <20140217073508.11156.21720.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

There is no C board code left for the EMEV2 SoC, so
get rid of the emev2.h include file to save some lines.
While at it make functions static.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.14-rc3-20140217

 Depends on "[PATCH v2] ARM: shmobile: Remove KZM9D board code"

 arch/arm/mach-shmobile/include/mach/emev2.h |    8 --------
 arch/arm/mach-shmobile/setup-emev2.c        |    7 ++++---
 arch/arm/mach-shmobile/smp-emev2.c          |    1 -
 3 files changed, 4 insertions(+), 12 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/emev2.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,8 +0,0 @@
-#ifndef __ASM_EMEV2_H__
-#define __ASM_EMEV2_H__
-
-extern void emev2_map_io(void);
-extern void emev2_init_delay(void);
-extern struct smp_operations emev2_smp_ops;
-
-#endif /* __ASM_EMEV2_H__ */
--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2014-02-17 16:30:05.000000000 +0900
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
-#include <mach/emev2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -38,12 +37,12 @@ static struct map_desc emev2_io_desc[] _
 #endif
 };
 
-void __init emev2_map_io(void)
+static void __init emev2_map_io(void)
 {
 	iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
 }
 
-void __init emev2_init_delay(void)
+static void __init emev2_init_delay(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
 }
@@ -59,6 +58,8 @@ static const char *emev2_boards_compat_d
 	NULL,
 };
 
+extern struct smp_operations emev2_smp_ops;
+
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2014-02-17 16:25:23.000000000 +0900
@@ -24,7 +24,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <mach/common.h>
-#include <mach/emev2.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
