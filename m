From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 21 Jul 2011 12:23:01 +0530
Subject: [PATCH 1/5] OMAP: I2C: Add a device reset field to platform data
In-Reply-To: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1311231185-5503-2-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under some conditions the driver may want to do a reset
of the device. Adding a reset field field to the platform
data.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 include/linux/i2c-omap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 98ae49b..8aa91b6 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -38,6 +38,7 @@ struct omap_i2c_bus_platform_data {
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);
 	int		(*device_idle) (struct platform_device *pdev);
+	int		(*device_reset) (struct device *dev);
 };
 
 #endif
-- 
1.7.1
