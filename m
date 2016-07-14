From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 14 Jul 2016 11:33:41 +0800
Subject: [PATCH 6/6] drm/rockchip: vop: correct rk3036 register define
In-Reply-To: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
References: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1468467221-6819-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Reported-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index a348a7a..919992c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -190,7 +190,7 @@ static const struct vop_data rk3288_vop = {
 	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
 };
 
-static const struct vop_scl_regs rk3066_win_scl = {
+static const struct vop_scl_regs rk3036_win_scl = {
 	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
 	.scale_cbcr_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
@@ -198,7 +198,7 @@ static const struct vop_scl_regs rk3066_win_scl = {
 };
 
 static const struct vop_win_phy rk3036_win0_data = {
-	.scl = &rk3066_win_scl,
+	.scl = &rk3036_win_scl,
 	.data_formats = formats_win_full,
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.enable = VOP_REG(RK3036_SYS_CTRL, 0x1, 0),
-- 
1.9.1
