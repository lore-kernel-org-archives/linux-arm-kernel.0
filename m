From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 20 Dec 2010 20:04:50 +0900
Subject: [PATCH] ARM: mach-shmobile: Clean up headsmp.S
Message-ID: <20101220110450.6824.92672.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use PAGE_OFFSET and PHYS_OFFSET for secondary_startup
entry point as recommended by Russell King.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on the AG5EVB board using the sh73a0 processor.

 Applies on top of the rmobile/smp topic branch in sh-2.6 git.

 arch/arm/mach-shmobile/headsmp.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S	2010-12-20 17:10:34.000000000 +0900
@@ -12,6 +12,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/memory.h>
 
 	__INIT
 
@@ -23,4 +24,4 @@
 	.align  12
 ENTRY(shmobile_secondary_vector)
 	ldr     pc, 1f
-1:	.long   secondary_startup - CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START
+1:	.long   secondary_startup - PAGE_OFFSET + PHYS_OFFSET
