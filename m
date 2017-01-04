From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  4 Jan 2017 10:55:52 +0100
Subject: [PATCH 2/2] drm/meson: Fix CVBS VDAC disable
In-Reply-To: <1483523752-14705-1-git-send-email-narmstrong@baylibre.com>
References: <1483523752-14705-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1483523752-14705-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the VDAC disabling register write values.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc_cvbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index c809c08..a2bcc70 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -167,7 +167,7 @@ static void meson_venc_cvbs_encoder_disable(struct drm_encoder *encoder)
 
 	/* Disable CVBS VDAC */
 	regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
-	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
+	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
 }
 
 static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
-- 
1.9.1
