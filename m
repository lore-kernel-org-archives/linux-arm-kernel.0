From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:33:01 +0100
Subject: [PATCH 08/11] drm/rockchip: enable rgb ouput of vops for vga and tv
 connectors
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-9-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The socs itself do not contain encoders for either vga or tv output.
Therefore these will be realized by external components and thus use the
rgb output.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c0387f7..b744888 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -863,6 +863,8 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 
 	switch (vop->connector_type) {
 	case DRM_MODE_CONNECTOR_LVDS:
+	case DRM_MODE_CONNECTOR_VGA:
+	case DRM_MODE_CONNECTOR_TV:
 		VOP_CTRL_SET(vop, rgb_en, 1);
 		break;
 	case DRM_MODE_CONNECTOR_eDP:
-- 
2.1.1
