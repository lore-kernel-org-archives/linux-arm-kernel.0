From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 07:12:21 +0100
Subject: [PATCH 7/8] Input: s3c24xx_ts - depend on SAMSUNG_DEV_TS and update
	menu entry
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274249542-28795-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the driver depend on either ARCH_S3C2410 (as legacy) or the new
device selection of SAMSUNG_DEV_TS.

Change the menuconfig name to reflect this driver is now handling more
devices that just the s3c2410.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/input/touchscreen/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 8a8fa4d..77a50d9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -158,8 +158,8 @@ config TOUCHSCREEN_FUJITSU
 	  module will be called fujitsu-ts.
 
 config TOUCHSCREEN_S3C2410
-	tristate "Samsung S3C2410 touchscreen input driver"
-	depends on ARCH_S3C2410
+	tristate "Samsung S3C2410/generic touchscreen input driver"
+	depends on ARCH_S3C2410 || SAMSUNG_DEV_TS
 	select S3C24XX_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
-- 
1.6.3.3
