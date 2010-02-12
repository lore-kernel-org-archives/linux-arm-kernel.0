From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2010 16:51:18 -0800
Subject: [PATCH 04/19] omap: Reconnect hsmmc context loss count
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Message-ID: <20100212005118.24958.4280.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Adrian Hunter <adrian.hunter@nokia.com>

Call the PM context-loss count function, now that there
is a prototype for it.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 2ba0d55..cc7e77f 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -16,6 +16,7 @@
 #include <mach/hardware.h>
 #include <plat/control.h>
 #include <plat/mmc.h>
+#include <plat/omap-pm.h>
 
 #include "hsmmc.h"
 
@@ -34,8 +35,7 @@ static struct hsmmc_controller {
 
 static int hsmmc_get_context_loss(struct device *dev)
 {
-	/* FIXME: PM DPS not implemented yet */
-	return 0;
+	return omap_pm_get_dev_context_loss_count(dev);
 }
 
 #else
