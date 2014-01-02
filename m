From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:00 +0000
Subject: [PATCH RFC 38/46] imx-drm: imx-drm-core: get rid of
 drm_mode_group_init_legacy_group()
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypp6-0007G3-2Z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're now operating like a conventional DRM driver, doing all
the initialisation within the driver's ->load callback, we don't
need to mess around with the mode groups - we can rely on the one
in the DRM platform code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 7872d13689ea..10cfea0e948a 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -274,12 +274,6 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 
 	drm_kms_helper_poll_init(drm);
 
-	/* setup the grouping for the legacy output */
-	ret = drm_mode_group_init_legacy_group(drm,
-			&drm->primary->mode_group);
-	if (ret)
-		goto err_kms;
-
 	ret = drm_vblank_init(drm, MAX_CRTC);
 	if (ret)
 		goto err_kms;
-- 
1.7.4.4
