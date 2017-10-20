From: seanpaul@chromium.org (Sean Paul)
Date: Fri, 20 Oct 2017 13:25:48 -0400
Subject: [PATCH] drm/rockchip: Fix build warning in analogix_dp-rockchip.c
Message-ID: <20171020172557.54900-1-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I didn't catch this before applying, just right after (of course).

Fixes:
../drivers/gpu/drm/rockchip/analogix_dp-rockchip.c: In function
?rockchip_dp_of_probe?:
../drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:276:6: warning:
unused variable ?ret? [-Wunused-variable]
  int ret;
        ^~~

Fixes: 102712a32ff5 ("drm/rockchip: analogix_dp: Remove unnecessary init
code")
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 8cae5ad926cd..39944c0f1c0b 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -273,7 +273,6 @@ static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
 {
 	struct device *dev = dp->dev;
 	struct device_node *np = dev->of_node;
-	int ret;
 
 	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 	if (IS_ERR(dp->grf)) {
-- 
2.15.0.rc0.271.g36b669edcc-goog
