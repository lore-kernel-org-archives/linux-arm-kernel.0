From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:53 +0100
Subject: [PATCH 02/15] serial: Use s3c2440 driver for S3C2416 SoC
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

UARTs in the S3C2416 are almost same as in S3C2443 and can be handled by
s3c2440 serial driver.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/serial/Kconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index f55c494..5f3f03d 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -518,12 +518,13 @@ config SERIAL_S3C2412
 	  Serial port support for the Samsung S3C2412 and S3C2413 SoC
 
 config SERIAL_S3C2440
-	tristate "Samsung S3C2440/S3C2442 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S3C2440 || CPU_S3C2442)
+	tristate "Samsung S3C2440/S3C2442/S3C2416 Serial port support"
+	depends on SERIAL_SAMSUNG && (CPU_S3C2440 || CPU_S3C2442 || CPU_S3C2416)
 	default y if CPU_S3C2440
 	default y if CPU_S3C2442
+	select SERIAL_SAMSUNG_UARTS_4 if CPU_S3C2416
 	help
-	  Serial port support for the Samsung S3C2440 and S3C2442 SoC
+	  Serial port support for the Samsung S3C2440, S3C2416 and S3C2442 SoC
 
 config SERIAL_S3C24A0
 	tristate "Samsung S3C24A0 Serial port support"
-- 
1.6.3.3
