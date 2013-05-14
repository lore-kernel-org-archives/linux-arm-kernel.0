From: jp.francois@cynove.com (jp.francois at cynove.com)
Date: Tue, 14 May 2013 18:07:01 +0200
Subject: [PATCH] ARM : omap : remove __init for _enable_preprogram
Message-ID: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_enable_preprogram is marked as __init, but is called from _enable which is not.
This results in oops once init is freed.
Fix this by removing the __init marker.

Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>

Index: b/arch/arm/mach-omap2/omap_hwmod.c
===================================================================
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2066,7 +2066,7 @@
  * do so is present in the hwmod data, then call it and pass along the
  * return value; otherwise, return 0.
  */
-static int __init _enable_preprogram(struct omap_hwmod *oh)
+static int _enable_preprogram(struct omap_hwmod *oh)
 {
 	if (!oh->class->enable_preprogram)
 		return 0;
