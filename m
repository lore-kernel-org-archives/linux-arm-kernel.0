From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 11:41:55 -0300
Subject: [PATCH 4/7] watchdog: orion: Allow to build in any Orion platform
In-Reply-To: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377182518-12554-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has no need for the mach-specific header, so remove it.
Therefore, it's no possible to allow builds in any Orion platform.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/Kconfig     | 2 +-
 drivers/watchdog/orion_wdt.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 362085d..524f30a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -282,7 +282,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
+	depends on PLAT_ORION
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index b4fd0a9..04ceb0e 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -25,7 +25,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <mach/bridge-regs.h>
 
 /*
  * Watchdog timer block registers.
-- 
1.8.1.5
