From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  7 Feb 2017 09:34:01 +0800
Subject: [PATCH] drm/rockchip: cdn-dp: fix cdn-dp complie warning
Message-ID: <1486431241-11374-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix warning:

drivers/gpu/drm/rockchip/cdn-dp-reg.c:632:24: warning:
  'val[1]' may be used uninitialized in this function [-Wmaybe-uninitialized]
  msa_misc = 2 * val[0] + 32 * val[1] +

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 3a5b8a4..319dbba 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -592,7 +592,7 @@ static int cdn_dp_get_msa_misc(struct video_info *video,
 			       struct drm_display_mode *mode)
 {
 	u32 msa_misc;
-	u8 val[2];
+	u8 val[2] = {0};
 
 	switch (video->color_fmt) {
 	case PXL_RGB:
-- 
1.9.1
