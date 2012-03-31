From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Mar 2012 16:33:31 +0800
Subject: [PATCH 1/2] regulator: fix sysfs name collision between dummy and
 fixed dummy regulator
Message-ID: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When regulator_register_fixed() is being used to register fixed dummy
regulator, the following line will be seen in the boot log.  And the
sysfs entry for fixed dummy regulator is not shown.

  dummy: Failed to create debugfs directory

The patch renames the fixed dummy supply to "fixed-dummy" to avoid
the name collision with dummy regulator.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/regulator/fixed-helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 30d0a15..efb52dc 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -32,7 +32,7 @@ struct platform_device *regulator_register_fixed(int id,
 	if (!data)
 		return NULL;
 
-	data->cfg.supply_name = "dummy";
+	data->cfg.supply_name = "fixed-dummy";
 	data->cfg.microvolts = 0;
 	data->cfg.gpio = -EINVAL;
 	data->cfg.enabled_at_boot = 1;
-- 
1.7.5.4
