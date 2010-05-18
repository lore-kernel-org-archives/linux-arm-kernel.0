From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 May 2010 20:45:06 +0900
Subject: [PATCH v3 9/9] Input: s3c24xx_ts - Modify touchscreen Kconfig for
	Support Samsung SoCs
Message-ID: <1274183106-16203-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna <ch.naveen@samsung.com>

This patch adds in touchscreen Kconfig the support for Samsung S3C6410,
S5P6440, and S5PV210/s5PC110 SoCs.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/input/touchscreen/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 8a8fa4d..a90a5bb 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -159,8 +159,8 @@ config TOUCHSCREEN_FUJITSU
 
 config TOUCHSCREEN_S3C2410
 	tristate "Samsung S3C2410 touchscreen input driver"
-	depends on ARCH_S3C2410
-	select S3C24XX_ADC
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5P6440 || ARCH_S5PV210
+	select S3C_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
 
-- 
1.6.2.5
