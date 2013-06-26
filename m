From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Jun 2013 11:53:09 +0200
Subject: [linux-next PATCH] ARM: OMAP: fix build for omap4-restart.c
Message-ID: <3975063.P6ddal97NH@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [linux-next PATCH] ARM: OMAP: fix build for omap4-restart.c

Building omap2plus_defconfig for next-20130626 results in the following
build error:

arch/arm/mach-omap2/omap4-restart.c:21:28: warning: ?enum reboot_mode? declared inside parameter list [enabled by default]
arch/arm/mach-omap2/omap4-restart.c:21:28: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
arch/arm/mach-omap2/omap4-restart.c:21:40: error: parameter 1 (?mode?) has incomplete type
arch/arm/mach-omap2/omap4-restart.c:21:6: warning: function declaration isn?t a prototype [-Wstrict-prototypes]

It is caused by commit 7eb135b ("reboot: arm: change reboot_mode to use
enum reboot_mode").

Fix it by adding missing include.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Robin Holt <holt@sgi.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-omap2/omap4-restart.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/arch/arm/mach-omap2/omap4-restart.c
===================================================================
--- a/arch/arm/mach-omap2/omap4-restart.c	2013-06-25 14:41:05.842382072 +0200
+++ b/arch/arm/mach-omap2/omap4-restart.c	2013-06-25 14:44:16.062381692 +0200
@@ -8,6 +8,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/reboot.h>
 #include "prminst44xx.h"
 
 /**
