From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 11:55:04 +0200
Subject: [PATCH v6 05/23] mfd: max77686: Return correct error when pdata isn't
 found
In-Reply-To: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404467722-26687-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When platform data is not found an -EIO (I/O error) code is returned.
This doesn't seem to be the correct error so better return -EINVAL
(Invalid argument) which is what most drivers do in this case.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 12d4c17..ada4976 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -129,7 +129,7 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 
 	if (!pdata) {
 		dev_err(&i2c->dev, "No platform data found.\n");
-		return -EIO;
+		return -EINVAL;
 	}
 
 	max77686 = devm_kzalloc(&i2c->dev,
-- 
2.0.0.rc2
