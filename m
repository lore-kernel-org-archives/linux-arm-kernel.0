From: andresgalacho@gmail.com (Andres Galacho)
Date: Mon,  1 May 2017 16:13:38 -0400
Subject: [RESEND PATCH] spi: bcm63xx-hsspi: Export OF device ID table as
 module aliases
Message-ID: <20170501201338.5368-1-andresgalacho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device table is required to load modules based on
modaliases. After adding MODULE_DEVICE_TABLE, below entries
for example will be added to module.alias:
alias:          of:N*T*Cbrcm,bcm6328-hsspiC*
alias:          of:N*T*Cbrcm,bcm6328-hsspi

Signed-off-by: Andres Galacho <andresgalacho@gmail.com>
---
 Resending patch since I forgot to add the lists as cc,
 sorry about the noise.

 drivers/spi/spi-bcm63xx-hsspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 5514cd02e93a..4da2d4a524ca 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -484,6 +484,7 @@ static const struct of_device_id bcm63xx_hsspi_of_match[] = {
 	{ .compatible = "brcm,bcm6328-hsspi", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_hsspi_of_match);
 
 static struct platform_driver bcm63xx_hsspi_driver = {
 	.driver = {
-- 
2.11.0
