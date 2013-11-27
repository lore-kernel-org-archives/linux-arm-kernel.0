From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 02:18:23 +0100
Subject: [PATCH 01/15] i2c: shmobile/rcar: Restrict non-COMPILE_TEST
 compilation
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1385515117-23664-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware supported by the i2c sh_mobile and rcar drivers is only found
on SUPERH or ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST
compilation to them.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/i2c/busses/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3b26129..92bdcf9 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -683,7 +683,7 @@ config I2C_SH7760
 
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
-	depends on SUPERH || ARM || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Renesas SH-Mobile processor.
@@ -796,7 +796,7 @@ config I2C_XLR
 
 config I2C_RCAR
 	tristate "Renesas R-Car I2C Controller"
-	depends on ARM || COMPILE_TEST
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  R-Car I2C controller.
-- 
1.8.3.2
