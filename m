From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:47 +0900
Subject: [PATCH 4/8] ARM: shmobile: Remove EMEV2 header file
In-Reply-To: <cover.1397627619.git.horms+renesas@verge.net.au>
References: <cover.1397627619.git.horms+renesas@verge.net.au>
Message-ID: <505891ec2558771cd84fe00fc1646275b4c069ed.1397627619.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

There is no C board code left for the EMEV2 SoC, so
get rid of the emev2.h include file to save some lines.
While at it make functions static.

Signed-off-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: Resolved conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/emev2.h | 8 --------
 arch/arm/mach-shmobile/setup-emev2.c        | 7 ++++---
 arch/arm/mach-shmobile/smp-emev2.c          | 1 -
 3 files changed, 4 insertions(+), 12 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/emev2.h

diff --git a/arch/arm/mach-shmobile/include/mach/emev2.h b/arch/arm/mach-shmobile/include/mach/emev2.h
deleted file mode 100644
index d64e188..0000000
--- a/arch/arm/mach-shmobile/include/mach/emev2.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef __ASM_EMEV2_H__
-#define __ASM_EMEV2_H__
-
-extern void emev2_map_io(void);
-extern void emev2_init_delay(void);
-extern struct smp_operations emev2_smp_ops;
-
-#endif /* __ASM_EMEV2_H__ */
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index b15a0ed..d953ff6 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
-#include <mach/emev2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -38,12 +37,12 @@ static struct map_desc emev2_io_desc[] __initdata = {
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
@@ -59,6 +58,8 @@ static const char *emev2_boards_compat_dt[] __initconst = {
 	NULL,
 };
 
+extern struct smp_operations emev2_smp_ops;
+
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index f2ca923..2dfd748 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -24,7 +24,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <mach/common.h>
-#include <mach/emev2.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-- 
1.8.5.2
