From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Jan 2014 13:18:25 +0100
Subject: [PATCH 01/18] regulator: max14577: Remove unused state container
 definition
In-Reply-To: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1390911522-28209-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the "struct max14577_regulator" because this is not used
anywhere. It should be removed earlier along with changing the driver
after review on the mailing lists.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/max14577.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/regulator/max14577.c b/drivers/regulator/max14577.c
index b1078ba3f393..38821458d413 100644
--- a/drivers/regulator/max14577.c
+++ b/drivers/regulator/max14577.c
@@ -1,7 +1,7 @@
 /*
  * max14577.c - Regulator driver for the Maxim 14577
  *
- * Copyright (C) 2013 Samsung Electronics
+ * Copyright (C) 2013,2014 Samsung Electronics
  * Krzysztof Kozlowski <k.kozlowski@samsung.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -22,12 +22,6 @@
 #include <linux/mfd/max14577-private.h>
 #include <linux/regulator/of_regulator.h>
 
-struct max14577_regulator {
-	struct device *dev;
-	struct max14577 *max14577;
-	struct regulator_dev **regulators;
-};
-
 static int max14577_reg_is_enabled(struct regulator_dev *rdev)
 {
 	int rid = rdev_get_id(rdev);
-- 
1.7.9.5
