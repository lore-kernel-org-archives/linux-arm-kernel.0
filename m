From: andy@warmcat.com (Andy Green)
Date: Tue, 15 Mar 2011 19:57:19 +0000
Subject: [PATCH 3 12/18] I2C: OMAP1/OMAP2+: add flags field to omap i2c
	platform data
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Message-ID: <20110315195719.30000.62104.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP I2C driver can access the configuration flags through
its platform data.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
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
