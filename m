From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  6 Aug 2015 09:19:49 -0500
Subject: [RFC PATCH 5/8] drm: bridge/analogix_dp: add platform device type
 support
In-Reply-To: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1438870789-23898-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/exynos/analogix_dp-exynos.c     | 1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 1 +
 include/drm/bridge/analogix_dp.h                | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/exynos/analogix_dp-exynos.c b/drivers/gpu/drm/exynos/analogix_dp-exynos.c
index b8d09d4..0668e77 100644
--- a/drivers/gpu/drm/exynos/analogix_dp-exynos.c
+++ b/drivers/gpu/drm/exynos/analogix_dp-exynos.c
@@ -124,6 +124,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->dev = dev;
 	dp->drm_dev = drm_dev;
 
+	dp->plat_data.dev_type = EXYNOS_DP;
 	dp->plat_data.power_on = exynos_dp_poweron;
 	dp->plat_data.power_off = exynos_dp_poweroff;
 	dp->plat_data.attach = exynos_dp_bridge_attach;
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 804048c..b532c21 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -312,6 +312,7 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	dp->plat_data.dev_type = RK3288_DP;
 	dp->plat_data.attach = NULL;
 	dp->plat_data.power_on = rockchip_dp_poweron;
 	dp->plat_data.power_off = rockchip_dp_poweroff;
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index 9a207f8..f317003 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -3,7 +3,13 @@
 
 #include <drm/drm_crtc.h>
 
+enum analogix_dp_devtype {
+	EXYNOS_DP,
+	RK3288_DP,
+};
+
 struct analogix_dp_plat_data {
+	enum analogix_dp_devtype dev_type;
 	struct drm_panel *panel;
 
 	int (*power_on)(struct analogix_dp_plat_data *);
-- 
2.1.2
