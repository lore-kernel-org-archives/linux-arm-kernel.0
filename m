From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:14 +0000
Subject: [PATCH 01/19] mfd: aat2870-core: Remove unnecessary 'out of memory'
 message
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Possible unnecessary 'out of memory' message
+       if (!aat2870) {
+               dev_err(&client->dev,

total: 0 errors, 1 warnings, 524 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/aat2870-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 29b6a2d..3ba19a4 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -373,11 +373,8 @@ static int aat2870_i2c_probe(struct i2c_client *client,
 
 	aat2870 = devm_kzalloc(&client->dev, sizeof(struct aat2870_data),
 				GFP_KERNEL);
-	if (!aat2870) {
-		dev_err(&client->dev,
-			"Failed to allocate memory for aat2870\n");
+	if (!aat2870)
 		return -ENOMEM;
-	}
 
 	aat2870->dev = &client->dev;
 	dev_set_drvdata(aat2870->dev, aat2870);
-- 
1.9.1
