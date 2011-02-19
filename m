From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 19 Feb 2011 16:12:38 +0530
Subject: [PATCH 17/17] omap4: Remove un-used do_wfi() macro.
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1298112158-28469-18-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With OMAP4 suspend, idle and hotplug series, we no longer need
do_wfi() macro.

Remove the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 74c9aa7..ca20333 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -16,12 +16,6 @@
 #include <asm/proc-fns.h>
 
 #ifndef __ASSEMBLER__
-/*
- * wfi used in low power code. Directly opcode is used instead
- * of instruction to avoid mulit-omap build break
- */
-#define do_wfi()			\
-		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
-- 
1.6.0.4
