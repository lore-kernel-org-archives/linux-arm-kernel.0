From: maarten.lankhorst@linux.intel.com (Maarten Lankhorst)
Date: Wed, 12 Jul 2017 10:13:41 +0200
Subject: [PATCH 13/16] drm/mediatek: Convert to new iterator macros
In-Reply-To: <20170712081344.25495-1-maarten.lankhorst@linux.intel.com>
References: <20170712081344.25495-1-maarten.lankhorst@linux.intel.com>
Message-ID: <20170712081344.25495-14-maarten.lankhorst@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_obj_in_state is about to be removed, so use the new atomic
iterator macros.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 56f802d0a51c..be0741638f94 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -48,11 +48,11 @@ static void mtk_atomic_schedule(struct mtk_drm_private *private,
 static void mtk_atomic_wait_for_fences(struct drm_atomic_state *state)
 {
 	struct drm_plane *plane;
-	struct drm_plane_state *plane_state;
+	struct drm_plane_state *new_plane_state;
 	int i;
 
-	for_each_plane_in_state(state, plane, plane_state, i)
-		mtk_fb_wait(plane->state->fb);
+	for_each_new_plane_in_state(state, plane, new_plane_state, i)
+		mtk_fb_wait(new_plane_state->fb);
 }
 
 static void mtk_atomic_complete(struct mtk_drm_private *private,
-- 
2.11.0
