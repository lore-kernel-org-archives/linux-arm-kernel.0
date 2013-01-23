From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 23 Jan 2013 14:32:43 +0800
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
Message-ID: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds at24c512b eeprom support.
The datasheet of at24c512b can be found at:
http://www.alldatasheet.com/datasheet-pdf/pdf/
256958/ATMEL/AT24C512B-TH-B.html

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 Documentation/devicetree/bindings/eeprom.txt |    2 +-
 drivers/misc/eeprom/at24.c                   |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom.txt b/Documentation/devicetree/bindings/eeprom.txt
index 4342c10..fcea214 100644
--- a/Documentation/devicetree/bindings/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom.txt
@@ -6,7 +6,7 @@ Required properties:
 		 If there is no specific driver for <manufacturer>, a generic
 		 driver based on <type> is selected. Possible types are:
 		 24c00, 24c01, 24c02, 24c04, 24c08, 24c16, 24c32, 24c64,
-		 24c128, 24c256, 24c512, 24c1024, spd
+		 24c128, 24c256, 24c512, 24c512b, 24c1024, spd
 
   - reg : the I2C address of the EEPROM
 
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2baeec5..0df4cb0 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -124,6 +124,7 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c128", AT24_DEVICE_MAGIC(131072 / 8, AT24_FLAG_ADDR16) },
 	{ "24c256", AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16) },
 	{ "24c512", AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16) },
+	{ "24c512b", AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16) },
 	{ "24c1024", AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16) },
 	{ "at24", 0 },
 	{ /* END OF LIST */ }
-- 
1.7.1
