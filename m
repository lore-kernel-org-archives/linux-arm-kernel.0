From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:48:08 +0100
Subject: [PATCH 4/5] drm: sti: add panel dependency
In-Reply-To: <1422452889-415782-1-git-send-email-arnd@arndb.de>
References: <1422452889-415782-1-git-send-email-arnd@arndb.de>
Message-ID: <1422452889-415782-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added sti driver requires the drm_panel helpers,
and we get a link error if they are not enabled

ERROR: "drm_panel_attach" [drivers/gpu/drm/sti/stidvo.ko] undefined!
ERROR: "of_drm_find_panel" [drivers/gpu/drm/sti/stidvo.ko] undefined!

This adds a 'select' statement as we have for the other drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/sti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
index d6d6b705b8c1..20d5f7787667 100644
--- a/drivers/gpu/drm/sti/Kconfig
+++ b/drivers/gpu/drm/sti/Kconfig
@@ -5,6 +5,7 @@ config DRM_STI
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
+	select DRM_PANEL
 	select FW_LOADER_USER_HELPER_FALLBACK
 	help
 	  Choose this option to enable DRM on STM stiH41x chipset
-- 
2.1.0.rc2
