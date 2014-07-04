From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 22:24:10 +0200
Subject: [PATCH v7 07/24] mfd: max77686: Remove unneeded OOM error message
In-Reply-To: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404505467-26526-8-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to print out-of-memory errors since this is already
done by the memory management subsystem which even calls dump_stack().

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/max77686.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 87fe52e..8650832 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -107,10 +107,8 @@ static struct max77686_platform_data *max77686_i2c_parse_dt_pdata(struct device
 	struct max77686_platform_data *pd;
 
 	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
-	if (!pd) {
-		dev_err(dev, "could not allocate memory for pdata\n");
+	if (!pd)
 		return NULL;
-	}
 
 	dev->platform_data = pd;
 	return pd;
-- 
2.0.0.rc2
