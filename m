From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:35 +0100
Subject: [PATCH v2 03/43] drm/sun4i: Add TODO comment about supporting scaling
 with the backend
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-4-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The backend allows integer-only scaling but can handle alpha components,
unlike the frontend. It could be useful to add support for this
eventually, so add a short TODO comment describing the situation.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 67b4bb4f5365..c3444246755b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -426,6 +426,11 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	if (IS_ERR(backend->frontend))
 		return false;
 
+	/*
+	 * TODO: The backend alone allows 2x and 4x integer scaling, including
+	 * support for an alpha component (which the frontend doesn't support).
+	 * Use the backend directly instead of the frontend in this case.
+	 */
 	return sun4i_backend_plane_uses_scaler(state);
 }
 
-- 
2.19.1
