From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 4 Sep 2011 19:24:16 +0530
Subject: [PATCH 15/25] OMAP4: Remove __INIT from omap_secondary_startup() to
	re-use it for hotplug.
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1315144466-9395-16-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the __INIT from omap_secondary_startup() so that it can
be re-used for CPU hotplug.

While at this, remove the un-used AUXBOOT register reference.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 4ee6aec..b13ef7e 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -18,11 +18,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-/* Physical address needed since MMU not enabled yet on secondary core */
-#define OMAP4_AUX_CORE_BOOT1_PA			0x48281804
-
-	__INIT
-
 /*
  * OMAP4 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
-- 
1.7.4.1
