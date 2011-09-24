From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 24 Sep 2011 11:44:36 +0530
Subject: [PATCH v2 16/24] OMAP4: Remove un-used do_wfi() macro.
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1316844884-21700-17-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With OMAP4 suspend, idle and hotplug series, we no longer need
do_wfi() macro.

Remove the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index ed3797c..e5db389 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -16,16 +16,6 @@
 #include <asm/proc-fns.h>
 
 #ifndef __ASSEMBLER__
-/*
- * wfi used in low power code. Directly opcode is used instead
- * of instruction to avoid mulit-omap build break
- */
-#ifdef CONFIG_THUMB2_KERNEL
-#define do_wfi() __asm__ __volatile__ ("wfi" : : : "memory")
-#else
-#define do_wfi()			\
-		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
-#endif
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *omap4_get_l2cache_base(void);
-- 
1.7.4.1
