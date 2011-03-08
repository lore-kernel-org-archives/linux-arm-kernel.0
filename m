From: andy@warmcat.com (Andy Green)
Date: Tue, 08 Mar 2011 11:07:57 +0000
Subject: [PATCH 2 05/18] I2C: OMAP: add rev to omap i2c platform data
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Message-ID: <20110308110757.23531.58382.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to pass the I2C IP revision from the hwmod class up
into the OMAP I2C driver, which does not have direct
access to it.

This adds a member to the platform data the OMAP I2C driver
does use already to hold the I2C IP revision.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 include/linux/i2c-omap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 701886d..b321211 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -17,6 +17,7 @@
 
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
+	u32		rev;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);
