From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:52:12 +0900
Subject: [PATCH] ARM: shmobile: Move SYSC base variable to inside ifdefs
Message-ID: <20140224055212.1822.52295.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the rcar_sysc_base variable to inside #ifdefs to avoid
triggering build warnings in case PM or SMP is not selected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "[PATCH 00/12] ARM: shmobile: Rework include path for SoC files"

 arch/arm/mach-shmobile/pm-rcar.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- 0013/arch/arm/mach-shmobile/pm-rcar.c
+++ work/arch/arm/mach-shmobile/pm-rcar.c	2014-02-24 14:09:44.000000000 +0900
@@ -15,8 +15,6 @@
 #include <asm/io.h>
 #include "pm-rcar.h"
 
-static void __iomem *rcar_sysc_base;
-
 /* SYSC */
 #define SYSCSR 0x00
 #define SYSCISR 0x04
@@ -35,6 +33,7 @@ static void __iomem *rcar_sysc_base;
 
 #if defined(CONFIG_PM) || defined(CONFIG_SMP)
 
+static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
 static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
