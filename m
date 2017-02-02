From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  2 Feb 2017 10:47:44 +0100
Subject: [PATCH 2/2] drm: meson: rename driver name to meson-drm
In-Reply-To: <1486028864-19622-1-git-send-email-narmstrong@baylibre.com>
References: <1486028864-19622-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1486028864-19622-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform driver name is currently "meson" which can lead to some
confusion, this patch renames it to "meson-drm" and removes the owner
attribute.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index ff1f601..380bde7 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -329,8 +329,7 @@ static int meson_drv_remove(struct platform_device *pdev)
 	.probe      = meson_drv_probe,
 	.remove     = meson_drv_remove,
 	.driver     = {
-		.owner  = THIS_MODULE,
-		.name   = DRIVER_NAME,
+		.name	= "meson-drm",
 		.of_match_table = dt_match,
 	},
 };
-- 
1.9.1
