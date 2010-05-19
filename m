From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 07:12:22 +0100
Subject: [PATCH 8/8] Input: s3c24xx_ts - fix selection of S3C_ADC
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274249542-28795-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change from S3C24XX_ADC to S3C_ADC missed changing the input
driver entry for the s3c2410 touchscreen, so fix the selection
of CONFIG_S3C_ADC.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 77a50d9..af57d3f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -160,7 +160,7 @@ config TOUCHSCREEN_FUJITSU
 config TOUCHSCREEN_S3C2410
 	tristate "Samsung S3C2410/generic touchscreen input driver"
 	depends on ARCH_S3C2410 || SAMSUNG_DEV_TS
-	select S3C24XX_ADC
+	select S3C_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
 
-- 
1.6.3.3
