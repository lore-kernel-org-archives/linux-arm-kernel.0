From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 26 Feb 2010 15:53:50 -0800
Subject: [PATCH 13/13] WATCHDOG: Add support for the LPC32XX arch
In-Reply-To: <1267228430-27193-1-git-send-email-wellsk40@gmail.com>
References: <1267228430-27193-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1267228430-27193-14-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Allow the PNX4008 watchdog driver to be reused with the
LPC32xx arch. Changed menu title to include the LCP32XX
device.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 drivers/watchdog/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 713b1ce..b882e09 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -205,11 +205,11 @@ config OMAP_WATCHDOG
 	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog timer.
 
 config PNX4008_WATCHDOG
-	tristate "PNX4008 Watchdog"
-	depends on ARCH_PNX4008
+	tristate "PNX4008/LPC32XX Watchdog"
+	depends on ARCH_PNX4008 || ARCH_LPC32XX
 	help
 	  Say Y here if to include support for the watchdog timer
-	  in the PNX4008 processor.
+	  in the PNX4008 or LPC32XX processors.
 	  This driver can be built as a module by choosing M. The module
 	  will be called pnx4008_wdt.
 
-- 
1.6.6
