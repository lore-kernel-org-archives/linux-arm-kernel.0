From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Oct 2009 17:26:29 -0700
Subject: [PATCH] omap: Split vmalloc.h for mach-omap1 and mach-omap2
Message-ID: <mailman.85.1256057845.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier patch "omap: Remap L3, L4 to get more kernel io address space"
changed the VMALLOC_END.

However, this change causes problems on mach-omap1:

BUG: mapping for 0xe0000000 at 0xe0000000 overlaps vmalloc space
BUG: mapping for 0xe1000000 at 0xe1000000 overlaps vmalloc space

Fix this by creating separate vmalloc.h files for mach-omap1
and mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/mach-omap1/include/mach/vmalloc.h
similarity index 86%
copy from arch/arm/plat-omap/include/mach/vmalloc.h
copy to arch/arm/mach-omap1/include/mach/vmalloc.h
index fc338a5..1b2af14 100644
--- a/arch/arm/plat-omap/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap1/include/mach/vmalloc.h
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/plat-omap/include/mach/vmalloc.h
+ *  arch/arm/mach-omap1/include/mach/vmalloc.h
  *
  *  Copyright (C) 2000 Russell King.
  *
@@ -17,8 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#ifdef CONFIG_ARCH_OMAP1
 #define VMALLOC_END	(PAGE_OFFSET + 0x18000000)
-#else
-#define VMALLOC_END	(PAGE_OFFSET + 0x38000000)
-#endif
diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/mach-omap2/include/mach/vmalloc.h
similarity index 85%
rename from arch/arm/plat-omap/include/mach/vmalloc.h
rename to arch/arm/mach-omap2/include/mach/vmalloc.h
index fc338a5..9ce9b6e 100644
--- a/arch/arm/plat-omap/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap2/include/mach/vmalloc.h
@@ -17,8 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#ifdef CONFIG_ARCH_OMAP1
-#define VMALLOC_END	(PAGE_OFFSET + 0x18000000)
-#else
-#define VMALLOC_END	(PAGE_OFFSET + 0x38000000)
-#endif
+#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
