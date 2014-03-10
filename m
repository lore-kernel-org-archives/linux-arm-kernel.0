From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 15:30:41 +0000
Subject: [PATCH] mfd: tps65218: Fix reported randconfig error
Message-ID: <1394465441-15040-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported error was:

  ERROR: "regmap_del_irq_chip" [drivers/mfd/tps65218.ko] undefined!
    when CONFIG_REGMAP_IRQ is not enabled.

Cc: Mark Brown <broonie@kernel.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7c443f2..456a7e7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -864,6 +864,7 @@ config MFD_TPS65218
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
+	select REGMAP_IRQ
 	help
 	  If you say yes here you get support for the TPS65218 series of
 	  Power Management chips.
-- 
1.8.3.2
