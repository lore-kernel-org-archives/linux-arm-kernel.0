From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Oct 2013 17:14:59 +0200
Subject: [PATCH] misc/at25, dt: support probing at25 SPI EEPROM from DT
Message-ID: <1381763699-13440-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

The commit d6ae0d578d24303941c1424b049d2cae28277666 introduced devicetree
binding documentation for this driver, but the driver itself does not yet
support the documented compatible entry. Fix this by adding the documented
entry to the driver.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/misc/eeprom/at25.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 840b359..4f3bca1 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -462,10 +462,17 @@ static int at25_remove(struct spi_device *spi)
 
 /*-------------------------------------------------------------------------*/
 
+static const struct of_device_id at25_of_match[] = {
+	{ .compatible = "atmel,at25", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, at25_of_match);
+
 static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
 		.owner		= THIS_MODULE,
+		.of_match_table = at25_of_match,
 	},
 	.probe		= at25_probe,
 	.remove		= at25_remove,
-- 
1.8.4.rc3
