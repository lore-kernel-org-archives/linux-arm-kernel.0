From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 6 Apr 2010 06:19:15 -0400
Subject: [PATCH] regulator: fix enabling regulator issue on max8925
Message-ID: <mailman.335.1272459566.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix regulator enabling issue that is caused by typo error in is_enabled().

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/regulator/max8925-regulator.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/max8925-regulator.c
b/drivers/regulator/max8925-regulator.c
index b6218f1..552cad8 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -109,7 +109,7 @@ static int max8925_is_enabled(struct regulator_dev *rdev)
 	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
 	int ret;

-	ret = max8925_reg_read(info->i2c, info->vol_reg);
+	ret = max8925_reg_read(info->i2c, info->enable_reg);
 	if (ret < 0)
 		return ret;

-- 
1.5.6.5
