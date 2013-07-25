From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Jul 2013 20:28:19 -0400
Subject: [PATCH 2/2] i2c: davinci: Allow i2c driver available for keystone
 platforms
In-Reply-To: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1374712099-32095-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone SOCs uses the same I2C IP as available on DaVinci SOCs.
Update the config so that ARCH_KEYSTONE can use it.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index dc6dea6..fcdd321 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -385,7 +385,7 @@ config I2C_CPM
 
 config I2C_DAVINCI
 	tristate "DaVinci I2C driver"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE
 	help
 	  Support for TI DaVinci I2C controller driver.
 
-- 
1.7.9.5
