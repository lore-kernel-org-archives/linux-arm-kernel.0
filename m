From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 14 Jul 2016 11:31:28 +0800
Subject: [PATCH 4/6] drm/rockchip: vop: add uv_vir register field for RK3036
 VOP
In-Reply-To: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
References: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1468467090-6108-5-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yakir Yang <ykk@rock-chips.com>

The WIN0 of RK3036 VOP could support YUV data format, but driver
forget to add the uv_vir register field for it.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 52661d1..a348a7a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -210,6 +210,7 @@ static const struct vop_win_phy rk3036_win0_data = {
 	.yrgb_mst = VOP_REG(RK3036_WIN0_YRGB_MST, 0xffffffff, 0),
 	.uv_mst = VOP_REG(RK3036_WIN0_CBR_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3036_WIN0_VIR, 0xffff, 0),
+	.uv_vir = VOP_REG(RK3036_WIN0_VIR, 0x1fff, 16),
 };
 
 static const struct vop_win_phy rk3036_win1_data = {
-- 
1.9.1
