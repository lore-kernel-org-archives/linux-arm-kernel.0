From: pieterg@gmx.com (pieterg)
Date: Fri, 13 Nov 2009 10:28:54 +0100
Subject: [PATCH] pxafb: added transparency field to pxafb_mode_info struct
Message-ID: <200911131028.54958.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From fe21c5a79464e0631ea8cf52db521dece06c5a1f Mon Sep 17 00:00:00 2001
From: pieterg <pieterg@gmx.com>
Date: Wed, 4 Nov 2009 10:55:18 +0100
Subject: [PATCH] pxafb: added transparency field to pxafb_mode_info struct

This allows to select either RGB565 (transparency 0) or RGBT555 (transparency 1) from the mode info

Signed-off-by: Pieter Grimmerink <p.grimmerink@inepro.com>
---
 arch/arm/mach-pxa/include/mach/pxafb.h |    3 ++-
 drivers/video/pxafb.c                  |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h b/arch/arm/mach-pxa/include/mach/pxafb.h
index f73061c..160ec83 100644
--- a/arch/arm/mach-pxa/include/mach/pxafb.h
+++ b/arch/arm/mach-pxa/include/mach/pxafb.h
@@ -76,7 +76,8 @@ struct pxafb_mode_info {
 	u_char		bpp;
 	u_int		cmap_greyscale:1,
 			depth:8,
-			unused:23;
+			transparency:1,
+			unused:22;
 
 	/* Parallel Mode Timing */
 	u_char		hsync_len;
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 1820c4a..91b19e3 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -397,6 +397,7 @@ static void pxafb_setmode(struct fb_var_screeninfo *var,
 	var->lower_margin	= mode->lower_margin;
 	var->sync		= mode->sync;
 	var->grayscale		= mode->cmap_greyscale;
+	var->transp.length	= mode->transparency;
 
 	/* set the initial RGBA bitfields */
 	pxafb_set_pixfmt(var, mode->depth);
-- 
1.6.5.rc1.44.ga1675
