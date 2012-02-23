From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 14:19:45 -0800
Subject: [PATCH] ARM: OMAP2+: Set Kconfig dependencies for PROC_DEVICETREE
Message-ID: <20120223221944.GC18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get:

warning: (ARCH_OMAP2PLUS) selects PROC_DEVICETREE which has
unmet direct dependencies (OF && PROC_FS && !SPARC)

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Looks like this is needed for what we have queued in the
omap dt branch.

--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -26,7 +26,7 @@ config ARCH_OMAP2PLUS
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
 	select USE_OF
-	select PROC_DEVICETREE
+	select PROC_DEVICETREE if PROC_FS
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
