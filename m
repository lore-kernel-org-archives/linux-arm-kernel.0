From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 28 Jan 2013 13:55:43 +0100
Subject: [PATCH] ARM: OMAP: hwmod_reset: Include errno.h to fix compilation
 error
Message-ID: <1359377743-30663-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without the errno.h:
  CC      arch/arm/mach-omap2/omap_hwmod_reset.o
arch/arm/mach-omap2/omap_hwmod_reset.c: In function ?omap_hwmod_aess_preprogram?:
arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: error: ?EINVAL? undeclared (first use in this function)
arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/mach-omap2/omap_hwmod_reset.o] Error 1

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Paul,

I could not find the patches from Sebastien's series:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82971.html

But AFAIK you have taken them for 3.9.

This patch is on top of it to fix compilation error.

Regards,
Peter

 arch/arm/mach-omap2/omap_hwmod_reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/omap_hwmod_reset.c
index bba43fa..65e186c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_reset.c
+++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
@@ -24,6 +24,7 @@
  * 02110-1301 USA
  */
 #include <linux/kernel.h>
+#include <linux/errno.h>
 
 #include <sound/aess.h>
 
-- 
1.8.1.1
