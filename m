From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:13 +0000
Subject: [PATCH 14/19] spi/atmel: remove incorrect __exit_p()
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-15-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we no longer allow building without hotplug, the
atmel_spi_remove function is always present and we should
not use __exit_p() to refer to it.

Without this patch, building at91_dt_defconfig results in:

drivers/spi/spi-atmel.c:1006:12: warning: 'atmel_spi_remove' defined but not used [-Wunused-function]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ab34497..656d137 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1088,7 +1088,7 @@ static struct platform_driver atmel_spi_driver = {
 	.suspend	= atmel_spi_suspend,
 	.resume		= atmel_spi_resume,
 	.probe		= atmel_spi_probe,
-	.remove		= __exit_p(atmel_spi_remove),
+	.remove		= atmel_spi_remove,
 };
 module_platform_driver(atmel_spi_driver);
 
-- 
1.8.0
