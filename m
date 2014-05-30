From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 30 May 2014 11:12:08 +0900
Subject: [PATCH] drm/exynos: remove unnecessary exynos_hdmi.h file
Message-ID: <000a01cf7bac$8f805f60$ae811e20$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos_hdmi.h has been used for the dedicated i2c drivers
that were already removed. Thus, the unnecessary exynos_hdmi.h
should be removed.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.h |   23 -----------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_hdmi.h

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.h b/drivers/gpu/drm/exynos/exynos_hdmi.h
deleted file mode 100644
index 0ddf395..0000000
--- a/drivers/gpu/drm/exynos/exynos_hdmi.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- * Authors:
- *	Inki Dae <inki.dae@samsung.com>
- *	Seung-Woo Kim <sw0312.kim@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef _EXYNOS_HDMI_H_
-#define _EXYNOS_HDMI_H_
-
-void hdmi_attach_ddc_client(struct i2c_client *ddc);
-void hdmi_attach_hdmiphy_client(struct i2c_client *hdmiphy);
-
-extern struct i2c_driver hdmiphy_driver;
-extern struct i2c_driver ddc_driver;
-
-#endif
-- 
1.7.10.4
