From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 15:27:45 +0530
Subject: [PATCH 1/8] ARM: OMAP2+: hwmod: Remove unused _HWMOD_WAKEUP_ENABLED
 flag
In-Reply-To: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361354272-18089-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

_HWMOD_WAKEUP_ENABLED is currently unused across the hwmod
framework. Just get rid of it, so we have one less flag to
worry about.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ----
 arch/arm/mach-omap2/omap_hwmod.h |    6 ++----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..b45c8fb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -608,8 +608,6 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
-	oh->_int_flags |= _HWMOD_WAKEUP_ENABLED;
-
 	return 0;
 }
 
@@ -643,8 +641,6 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
-	oh->_int_flags &= ~_HWMOD_WAKEUP_ENABLED;
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 3ae852a..23f530b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -468,15 +468,13 @@ struct omap_hwmod_omap4_prcm {
  * These are for internal use only and are managed by the omap_hwmod code.
  *
  * _HWMOD_NO_MPU_PORT: no path exists for the MPU to write to this module
- * _HWMOD_WAKEUP_ENABLED: set when the omap_hwmod code has enabled ENAWAKEUP
  * _HWMOD_SYSCONFIG_LOADED: set when the OCP_SYSCONFIG value has been cached
  * _HWMOD_SKIP_ENABLE: set if hwmod enabled during init (HWMOD_INIT_NO_IDLE) -
  *     causes the first call to _enable() to only update the pinmux
  */
 #define _HWMOD_NO_MPU_PORT			(1 << 0)
-#define _HWMOD_WAKEUP_ENABLED			(1 << 1)
-#define _HWMOD_SYSCONFIG_LOADED			(1 << 2)
-#define _HWMOD_SKIP_ENABLE			(1 << 3)
+#define _HWMOD_SYSCONFIG_LOADED			(1 << 1)
+#define _HWMOD_SKIP_ENABLE			(1 << 2)
 
 /*
  * omap_hwmod._state definitions
-- 
1.7.9.5
