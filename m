From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:47:46 +0100
Subject: [PATCH 4/9] ARM: omap: add include guard for soc.h
In-Reply-To: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
Message-ID: <1360882071-4072668-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e4c060db "ARM: OMAP: Split plat/cpu.h into local soc.h for
mach-omap1 and mach-omap2" moved the bulk of "plat/cpu.h" into "cpu.h"
but did not add an include guard for the new file that was present
in the old one. There are cases where the file is indeed included
multiple times, probably by accident, but adding the include
guard ensures that this has no further consequences.

Without this patch, building allmodconfig results in lots of warnings like:

In file included from arch/arm/mach-omap2/drm.c:31:0:
arch/arm/mach-omap2/soc.h:206:0: warning: "cpu_is_omap24xx" redefined [enabled by default]
In file included from arch/arm/mach-omap2/drm.c:28:0:
arch/arm/mach-omap2/soc.h:227:0: note: this is the location of the previous definition
In file included from arch/arm/mach-omap2/drm.c:31:0:
arch/arm/mach-omap2/soc.h:207:0: warning: "cpu_is_omap242x" redefined [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/soc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index c62116b..97dd373 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -24,6 +24,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  */
+#ifndef OMAP2_SOC_H
+#define OMAP2_SOC_H
 
 #include "omap24xx.h"
 #include "omap34xx.h"
@@ -497,3 +499,4 @@ level(__##fn);
 
 #endif	/* __ASSEMBLY__ */
 
+#endif
-- 
1.8.1.2
