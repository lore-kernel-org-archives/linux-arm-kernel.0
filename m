From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 27 Jan 2010 17:43:19 -0800
Subject: [PATCH 01/13] i2c_pnx: Added Kconfig support for the LCP32XX
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1264643011-17390-2-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The existing PNX4008 support for I2C was re-used. The option to select
the PNX4008 driver in the kernel config is now also based on the
ARCH_LCP32XX config flag.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 drivers/i2c/busses/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..590a441 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -467,8 +467,8 @@ config I2C_PASEMI
 	  Supports the PA Semi PWRficient on-chip SMBus interfaces.
 
 config I2C_PNX
-	tristate "I2C bus support for Philips PNX targets"
-	depends on ARCH_PNX4008
+	tristate "I2C bus support for Philips/NXP devices"
+	depends on ARCH_PNX4008 || ARCH_LPC32XX
 	help
 	  This driver supports the Philips IP3204 I2C IP block master and/or
 	  slave controller
-- 
1.6.6
