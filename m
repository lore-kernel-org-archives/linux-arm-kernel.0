From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 13:46:35 +0200
Subject: [PATCH 15/16] i2c: i2c-tegra: Drop class based scanning to improve
 bootup time
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1404992799-3705-16-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has been flagged to drop class based instantiation. The removal
improves boot-up time and is unneeded for embedded controllers. Users have been
warned to switch for some time now, so we can actually do the removal. Keep the
DEPRECATED flag, so the core can inform users that the behaviour finally
changed now. After another transition period, this flag can go, too.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index f1bb2fc06791..87d0371cebb7 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -792,7 +792,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 
 	i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
 	i2c_dev->adapter.owner = THIS_MODULE;
-	i2c_dev->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
+	i2c_dev->adapter.class = I2C_CLASS_DEPRECATED;
 	strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
 		sizeof(i2c_dev->adapter.name));
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
-- 
2.0.0
