From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 27 Dec 2014 19:52:59 +0200
Subject: [PATCH 7/7] mfd: menelaus: use macro for magic number
In-Reply-To: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <1419702779-16001-8-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use macro to check a register bit.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mfd/menelaus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 8660adf..05bae40 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1242,7 +1242,7 @@ static int menelaus_probe(struct i2c_client *client,
 	err = menelaus_read_reg(MENELAUS_VCORE_CTRL1);
 	if (err < 0)
 		goto fail;
-	if (err & BIT(7))
+	if (err & VCORE_CTRL1_HW_NSW)
 		menelaus->vcore_hw_mode = 1;
 	else
 		menelaus->vcore_hw_mode = 0;
-- 
2.2.0
