From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Apr 2012 13:05:37 -0700
Subject: [PATCH 3/6] ARM: OMAP4: hwmod: drop extra cpu_is check from
 _wait_target_disable()
In-Reply-To: <1335557140-10854-1-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
Message-ID: <1335557140-10854-4-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_omap4_wait_target_disable() is called only from inside _omap4_disable_module()
which is already protected by SoC specific checks.  Remove the cpu_is check
here.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a978350..3641b0a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -803,9 +803,6 @@ static void _omap4_enable_module(struct omap_hwmod *oh)
  */
 static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 {
-	if (!cpu_is_omap44xx())
-		return 0;
-
 	if (!oh)
 		return -EINVAL;
 
-- 
1.7.9.2
