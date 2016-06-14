From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Jun 2016 17:07:27 +0200
Subject: [PATCH 09/10] i2c: designware-platdrv: Simplify code by using
 dev_get_drvdata()
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465916848-8207-10-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 2b91af3..b2c6037 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -310,8 +310,7 @@ static void dw_i2c_plat_complete(struct device *dev)
 #ifdef CONFIG_PM
 static int dw_i2c_plat_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
 	i2c_dw_disable(i_dev);
 
@@ -323,8 +322,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
 
 static int dw_i2c_plat_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 	int ret;
 
 	if (!IS_ERR(i_dev->clk)) {
-- 
1.9.1
