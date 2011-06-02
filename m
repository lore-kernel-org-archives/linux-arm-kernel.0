From: khilman@ti.com (Kevin Hilman)
Date: Wed,  1 Jun 2011 17:19:38 -0700
Subject: [PATCH v4 12/18] I2C: OMAP1/OMAP2+: add flags field to omap i2c
	platform data
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Message-ID: <1306973984-15165-13-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy@warmcat.com>

OMAP I2C driver can access the configuration flags through
its platform data.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 include/linux/i2c-omap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index b321211..776c8e1 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -18,6 +18,7 @@
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
+	u32		flags;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);
-- 
1.7.4
