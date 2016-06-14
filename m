From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Jun 2016 17:07:24 +0200
Subject: [PATCH 06/10] i2c: designware-platdrv: Update runtime PM last busy
 mark in ->probe()
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465916848-8207-7-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid the device to be immediately runtime suspended when ->probe()
returns, update the last busy mark to use the delay from autosuspend.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4083376..106856f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -253,6 +253,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		if (dev->pm_runtime_disabled)
 			pm_runtime_put_noidle(&pdev->dev);
 	}
+	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put(&pdev->dev);
 
 	return r;
-- 
1.9.1
