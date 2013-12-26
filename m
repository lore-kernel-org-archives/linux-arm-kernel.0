From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 26 Dec 2013 14:52:43 +0800
Subject: [PATCH] regulator: act8865: fix incorrect devm_kzalloc for act8865
Message-ID: <1388040763-15653-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Which cause to allocate more needless memory.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/regulator/act8865-regulator.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index f853353..aecf01b 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -290,9 +290,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	act8865 = devm_kzalloc(dev, sizeof(struct act8865) +
-			sizeof(struct regulator_dev *) * ACT8865_REG_NUM,
-			GFP_KERNEL);
+	act8865 = devm_kzalloc(dev, sizeof(struct act8865), GFP_KERNEL);
 	if (!act8865)
 		return -ENOMEM;
 
-- 
1.7.9.5
