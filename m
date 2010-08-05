From: wellsk40@gmail.com (Kevin Wells)
Date: Thu, 5 Aug 2010 15:40:17 -0700
Subject: [PATCH] i2c: Enable NXP LPC support in Kconfig
Message-ID: <AANLkTimD2Odr2zTF5fammq9i+yeCTjOMqG+NXjiLnB-i@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC series processors use the IP3204 I2C block shared with the
Philips PNX4008 processor.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 drivers/i2c/busses/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index bceafbf..77eabae 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -496,8 +496,8 @@ config I2C_PMCMSP
 	  will be called i2c-pmcmsp.

 config I2C_PNX
-	tristate "I2C bus support for Philips PNX targets"
-	depends on ARCH_PNX4008
+	tristate "I2C bus support for Philips PNX and NXP LPC targets"
+	depends on ARCH_PNX4008 || ARCH_LPC32XX
 	help
 	  This driver supports the Philips IP3204 I2C IP block master and/or
 	  slave controller
-- 
1.7.1.1
