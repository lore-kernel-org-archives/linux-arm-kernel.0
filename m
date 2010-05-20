From: tklauser@distanz.ch (Tobias Klauser)
Date: Thu, 20 May 2010 17:12:52 +0200
Subject: [PATCH] OMAP: DSS2: storage class should be before const qualifier
Message-ID: <1274368372-4043-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm/plat-omap/include/plat/display.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 1c529ce..fbbb966 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -277,8 +277,8 @@ struct omap_video_timings {
  * identify the mode, and does not actually use the configs
  * itself. However, the configs should be something that
  * a normal monitor can also show */
-const extern struct omap_video_timings omap_dss_pal_timings;
-const extern struct omap_video_timings omap_dss_ntsc_timings;
+extern const struct omap_video_timings omap_dss_pal_timings;
+extern const struct omap_video_timings omap_dss_ntsc_timings;
 #endif
 
 struct omap_overlay_info {
-- 
1.6.3.3
