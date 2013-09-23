From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Mon, 23 Sep 2013 11:45:45 +0200
Subject: [PATCH] spi: s3c64xx: Add missing compatibles
Message-ID: <1379929545-27517-1-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatibles for s3c6410, s5pc100 and s5pc110/s5pv210 boards.

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8bed27a..84cc6ac 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1612,6 +1612,18 @@ static struct platform_device_id s3c64xx_spi_driver_ids[] = {
 };
 
 static const struct of_device_id s3c64xx_spi_dt_match[] = {
+	{ .compatible = "samsung,s3c2443-spi",
+			.data = (void *)&s3c2443_spi_port_config,
+	},
+	{ .compatible = "samsung,s3c6410-spi",
+			.data = (void *)&s3c6410_spi_port_config,
+	},
+	{ .compatible = "samsung,s5pc100-spi",
+			.data = (void *)&s5pc100_spi_port_config,
+	},
+	{ .compatible = "samsung,s5pv210-spi",
+			.data = (void *)&s5pv210_spi_port_config,
+	},
 	{ .compatible = "samsung,exynos4210-spi",
 			.data = (void *)&exynos4_spi_port_config,
 	},
-- 
1.8.1.2
