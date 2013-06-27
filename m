From: vincent.stehle@freescale.com (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Thu, 27 Jun 2013 14:26:00 +0200
Subject: [PATCH linux-next] ARM: OMAP2+: fix omap4-restart compilation
Message-ID: <1372335961-31401-1-git-send-email-vincent.stehle@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following compilation error due to missing include file:

  arch/arm/mach-omap2/omap4-restart.c:21:28: warning: ?enum reboot_mode? declared inside parameter list [enabled by default]
  arch/arm/mach-omap2/omap4-restart.c:21:28: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
  arch/arm/mach-omap2/omap4-restart.c:21:40: error: parameter 1 (?mode?) has incomplete type
  arch/arm/mach-omap2/omap4-restart.c:21:6: warning: function declaration isn?t a prototype [-Wstrict-prototypes]
  make[1]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1

Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: trivial at kernel.org
---


Hi,

This fixes the build of linux-next for arch ARM, config multi_v7_defconfig, tag
next-20130627.

Best regards,

V.


 arch/arm/mach-omap2/omap4-restart.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
index 652adde..41dfd7d 100644
--- a/arch/arm/mach-omap2/omap4-restart.c
+++ b/arch/arm/mach-omap2/omap4-restart.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/reboot.h>
 #include "prminst44xx.h"
 
 /**
-- 
1.7.10.4
