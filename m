From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  2 Mar 2017 16:40:00 +0100
Subject: [PATCH 04/11] drm/meson: venc_cvbs: no more return -ENODEV if CVBS is
 not available
In-Reply-To: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
References: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488469207-523-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since this is managed now by the components code, if CVBS is not available
and HDMI neither, the drm driver won't bind anyway.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc_cvbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index a2bcc70..a96fcb4 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -248,7 +248,7 @@ int meson_venc_cvbs_create(struct meson_drm *priv)
 
 	if (!meson_venc_cvbs_connector_is_available(priv)) {
 		dev_info(drm->dev, "CVBS Output connector not available\n");
-		return -ENODEV;
+		return 0;
 	}
 
 	meson_venc_cvbs = devm_kzalloc(priv->dev, sizeof(*meson_venc_cvbs),
-- 
1.9.1
