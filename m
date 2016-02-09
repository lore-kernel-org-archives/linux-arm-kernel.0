From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Feb 2016 13:28:15 +0100
Subject: [PATCH] drm/tegra: remove unused variable
Message-ID: <1455020923-1089878-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A newly merged patch removed the only user of this variable,
leading to a harmless gcc warning:

drivers/gpu/drm/tegra/drm.c: In function 'tegra_drm_preclose':
drivers/gpu/drm/tegra/drm.c:861:19: error: unused variable 'crtc' [-Werror=unused-variable]

This removes the variable as well.

Cc: Terje Bergstr?m <tbergstrom@nvidia.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Fixes: 0417d424ac0d ("drm/tegra: Stop cancelling page flip events")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tegra/drm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 021d0e1398fb..8e6b18caa706 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -858,7 +858,6 @@ static void tegra_drm_preclose(struct drm_device *drm, struct drm_file *file)
 {
 	struct tegra_drm_file *fpriv = file->driver_priv;
 	struct tegra_drm_context *context, *tmp;
-	struct drm_crtc *crtc;
 
 	list_for_each_entry_safe(context, tmp, &fpriv->contexts, list)
 		tegra_drm_context_free(context);
-- 
2.7.0
