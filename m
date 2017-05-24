From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 May 2017 16:32:06 +0200
Subject: [PATCH] gpio: mvebu: Select REGMAP_MMIO now that regmap is used
Message-ID: <20170524143206.9727-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the commit "gpio: mvebu: switch to regmap for register access" the
driver use the regmap. Explicitly select the REGMAP_MMIO symbol to fix
build error.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 45ed9acfd095..68d9e6bde14d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -339,6 +339,7 @@ config GPIO_MVEBU
 	depends on PLAT_ORION
 	depends on OF_GPIO
 	select GENERIC_IRQ_CHIP
+	select REGMAP_MMIO
 
 config GPIO_MXC
 	def_bool y
-- 
2.11.0
