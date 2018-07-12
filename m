From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 12 Jul 2018 11:50:28 -0400
Subject: [PATCH] drm/sun41: Fix incorrect return type
Message-ID: <20180712155037.211625-1-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're returning -errno instead of ERR_PTR(-errno).

Fixes: af11942ee44e ("drm/sun4i: tcon-top: Cleanup clock handling")
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 046f8dd66f90..55fe398d8290 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -99,7 +99,7 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
 
 	index = of_property_match_string(dev->of_node, "clock-names", parent);
 	if (index < 0)
-		return index;
+		return ERR_PTR(index);
 
 	parent_name = of_clk_get_parent_name(dev->of_node, index);
 
-- 
Sean Paul, Software Engineer, Google / Chromium OS
