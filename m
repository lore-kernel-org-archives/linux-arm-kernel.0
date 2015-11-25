From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:06:46 +0100
Subject: [PATCH 01/10] Input: s3c2410_ts: fix S3C_ADC dependency
In-Reply-To: <1448467615-447097-1-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
Message-ID: <1448467615-447097-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C_ADC is only available on machines that don't do ARCH_MULTIPLATFORM,
so changing the 'select' into 'depends on' here helps us move to
ARCH_MULTIPLATFORM without introducing regressions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index ae33da7ab51f..ae35edcd6a34 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -365,7 +365,7 @@ config TOUCHSCREEN_IPROC
 config TOUCHSCREEN_S3C2410
 	tristate "Samsung S3C2410/generic touchscreen input driver"
 	depends on ARCH_S3C24XX || SAMSUNG_DEV_TS
-	select S3C_ADC
+	depends on S3C_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
 
-- 
2.1.0.rc2
