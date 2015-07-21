From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Jul 2015 16:25:40 +0800
Subject: [PATCH v3 4/6] drm/rockchip: vop: Default enable win2/3 area0 bit
In-Reply-To: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1437467140-13881-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Win2/3 support multiple area function, but we haven't found
a suitable way to use it yet, so let's just use them as other windows
with only area 0 enabled.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3:
Adviced by Tomasz Figa
- fix patch comments.
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 47ce943..e08f318 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -276,6 +276,12 @@ static const struct vop_reg_data vop_init_reg_table[] = {
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
