From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Tue, 30 Oct 2012 19:39:41 +0900
Subject: [PATCH] i2c: mv64xxx: Add support Armada-XP SoC
Message-ID: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada-XP SoC has the same I2C controller as mv64xxxi-i2c.
This validates to use mv64xxx in this SoC.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 65dd599..ff53cf4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -474,7 +474,7 @@ config I2C_MPC
 
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
-	depends on (MV64X60 || PLAT_ORION)
+	depends on (MV64X60 || PLAT_ORION || MACH_ARMADA_370_XP)
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
-- 
1.7.10.4
