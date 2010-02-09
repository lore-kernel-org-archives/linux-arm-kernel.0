From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  8 Feb 2010 16:11:35 -0800
Subject: [PATCH 14/14] WATCHDOG: Add support for the LPC32XX arch
In-Reply-To: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1265674295-23996-15-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Allow the pnx4408 watchdog  driver to be reused with the
LPC32xx arch. Changed menu title to include the LCP32XX
device.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 drivers/watchdog/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 050ee14..3019415 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -200,11 +200,11 @@ config OMAP_WATCHDOG
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
