From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 26 Jun 2015 18:10:32 +0800
Subject: [PATCH v2 5/5] drm/rockchip: default enable win2/3 area0 bit
In-Reply-To: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1435313432-4923-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Win2/3 support 4 area display, but now havn't found a suitable
way to use it, and it enable by win gate and area gate,
so default enable area0 gate, so that its behaviour just like a
win.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 40107bb..e001d26 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -337,6 +337,12 @@ static const struct vop_reg_data vop_init_reg_table[] = {
 	{DSP_CTRL0, 0x00000000},
 	{WIN0_CTRL0, 0x00000080},
 	{WIN1_CTRL0, 0x00000080},
+	/*
+	 * Todo: win2/3 support area func, but now havn't found a suitable
+	 * way to use it, so default enable area0 as a win display.
+	 */
+	{WIN2_CTRL0, 0x00000010},
+	{WIN3_CTRL0, 0x00000010},
 };
 
 /*
-- 
1.7.9.5
