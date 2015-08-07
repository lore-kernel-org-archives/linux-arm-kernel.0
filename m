From: ykk@rock-chips.com (Yakir Yang)
Date: Fri,  7 Aug 2015 05:46:35 -0500
Subject: [PATCH v2 5/8] drm: bridge/analogix_dp: add platform device type
 support
In-Reply-To: <1438943674-18191-1-git-send-email-ykk@rock-chips.com>
References: <1438943674-18191-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1438944396-18951-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v2:
- Add GNU license v2 declared and samsung copyright

 drivers/gpu/drm/exynos/analogix_dp-exynos.c     |  1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  1 +
 include/drm/bridge/analogix_dp.h                | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/exynos/analogix_dp-exynos.c b/drivers/gpu/drm/exynos/analogix_dp-exynos.c
index 1468ce7..5a2027d 100644
--- a/drivers/gpu/drm/exynos/analogix_dp-exynos.c
+++ b/drivers/gpu/drm/exynos/analogix_dp-exynos.c
@@ -122,6 +122,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->dev = dev;
 	dp->drm_dev = drm_dev;
 
+	dp->plat_data.dev_type = EXYNOS_DP;
 	dp->plat_data.power_on = exynos_dp_poweron;
 	dp->plat_data.power_off = exynos_dp_poweroff;
 	dp->plat_data.attach = exynos_dp_bridge_attach;
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 2f86e5e..e7cf9ab 100644
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
index 9a207f8..d5f9a5b 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -1,9 +1,25 @@
+/*
+ * Analogix Core DP (Display Port) interface driver.
+ *
+ * Copyright (C) 2012 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
 #ifndef _ANALOGIX_DP_H_
 #define _ANALOGIX_DP_H_
 
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
1.9.1
