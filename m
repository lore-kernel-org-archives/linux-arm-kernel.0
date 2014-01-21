From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 06:12:40 -0300
Subject: [PATCH v2 14/15] watchdog: orion: Allow to build on any Orion platform
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390295561-3466-15-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After getting rid of all the mach-specific code, it's now possible
to allow builds in any Orion platform.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5be6e91..1689f72 100644
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
-- 
1.8.1.5
