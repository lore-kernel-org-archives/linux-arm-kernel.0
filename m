From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:43 +0200
Subject: [PATCH 2/7] drm: make gamma_set optional
In-Reply-To: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334158428-23735-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpu/drm/drm_crtc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index b14496e..75f66a5 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -3108,6 +3108,11 @@ int drm_mode_gamma_set_ioctl(struct drm_device *dev,
 		goto out;
 	}
 
+	if (!crtc->funcs->gamma_set) {
+		ret = -ENOSYS;
+		goto out;
+	}
+
 	crtc->funcs->gamma_set(crtc, r_base, g_base, b_base, 0, crtc->gamma_size);
 
 out:
-- 
1.7.9.5
