From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 27 Jul 2015 10:06:00 +0800
Subject: [PATCH v4 4/6] drm/rockchip: vop: Default enable win2/3 area0 bit
In-Reply-To: <1437962762-19157-1-git-send-email-mark.yao@rock-chips.com>
References: <1437962762-19157-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1437962762-19157-5-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Win2/3 support multiple area function, but we haven't found
a suitable way to use it yet, so let's just use them as other windows
with only area 0 enabled.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v4: None

Changes in v3:
Adviced by Tomasz Figa
- fix patch comments.
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c1264d5..4a2923b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -279,6 +279,12 @@ static const struct vop_reg_data vop_init_reg_table[] = {
 	{DSP_CTRL0, 0x00000000},
 	{WIN0_CTRL0, 0x00000080},
 	{WIN1_CTRL0, 0x00000080},
+	/* TODO: Win2/3 support multiple area function, but we haven't found
+	 * a suitable way to use it yet, so let's just use them as other windows
+	 * with only area 0 enabled.
+	 */
+	{WIN2_CTRL0, 0x00000010},
+	{WIN3_CTRL0, 0x00000010},
 };
 
 /*
-- 
1.7.9.5
