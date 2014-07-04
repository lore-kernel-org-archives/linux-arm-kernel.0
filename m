From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 11:55:03 +0200
Subject: [PATCH v6 04/23] mfd: max77686: Make platform data over-rule DT
In-Reply-To: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404467722-26687-5-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function max77802_i2c_parse_dt_pdata() should only be called
if there isn't already platform data for the device.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index d1f9d04..12d4c17 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -124,7 +124,7 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 	unsigned int data;
 	int ret = 0;
 
-	if (IS_ENABLED(CONFIG_OF) && i2c->dev.of_node)
+	if (IS_ENABLED(CONFIG_OF) && i2c->dev.of_node && !pdata)
 		pdata = max77686_i2c_parse_dt_pdata(&i2c->dev);
 
 	if (!pdata) {
-- 
2.0.0.rc2
