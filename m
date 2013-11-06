From: robherring2@gmail.com (Rob Herring)
Date: Tue,  5 Nov 2013 21:27:02 -0600
Subject: [PATCH] gpio: pl061: don't depend on CONFIG_ARM
Message-ID: <1383708422-20374-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The pl061 driver has no real dependency on ARM, so remove the kconfig
dependency.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio at vger.kernel.org
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a0471e6..0f04444 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -213,7 +213,7 @@ config GPIO_OCTEON
 
 config GPIO_PL061
 	bool "PrimeCell PL061 GPIO support"
-	depends on ARM && ARM_AMBA
+	depends on ARM_AMBA
 	select GENERIC_IRQ_CHIP
 	help
 	  Say yes here to support the PrimeCell PL061 GPIO device
-- 
1.8.1.2
