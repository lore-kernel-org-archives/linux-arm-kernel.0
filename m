From: swarren@nvidia.com (Stephen Warren)
Date: Sat, 17 Dec 2011 23:29:29 -0700
Subject: [PATCH V2 1/4] i2c: tegra: Add __devinit/exit to probe/remove
Message-ID: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes some section mismatch build warnings.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: New patch.

 drivers/i2c/busses/i2c-tegra.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 46b6500..e8560ed 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -558,7 +558,7 @@ static const struct i2c_algorithm tegra_i2c_algo = {
 	.functionality	= tegra_i2c_func,
 };
 
-static int tegra_i2c_probe(struct platform_device *pdev)
+static int __devinit tegra_i2c_probe(struct platform_device *pdev)
 {
 	struct tegra_i2c_dev *i2c_dev;
 	struct tegra_i2c_platform_data *pdata = pdev->dev.platform_data;
@@ -690,7 +690,7 @@ err_iounmap:
 	return ret;
 }
 
-static int tegra_i2c_remove(struct platform_device *pdev)
+static int __devexit tegra_i2c_remove(struct platform_device *pdev)
 {
 	struct tegra_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 	i2c_del_adapter(&i2c_dev->adapter);
-- 
1.7.5.4
