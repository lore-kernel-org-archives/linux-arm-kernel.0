From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 26 Jul 2017 11:03:49 +0100
Subject: [PATCH] i2c: allow i2c-versatile for ARM MPS platforms
Message-ID: <E1daJAT-0003kF-TG@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow i2c-versatile to be enabled for ARM MPS platforms.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index b6ed94636267..3d2c9bdf4acd 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -990,7 +990,7 @@ config I2C_UNIPHIER_F
 
 config I2C_VERSATILE
 	tristate "ARM Versatile/Realview I2C bus support"
-	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || COMPILE_TEST
+	depends on ARCH_MPS2 || ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || COMPILE_TEST
 	select I2C_ALGOBIT
 	help
 	  Say yes if you want to support the I2C serial bus on ARMs Versatile
-- 
2.7.4
