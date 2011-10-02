From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 16:45:49 +0200
Subject: [PATCH 19/30] tty/serial/omap: console can only be built-in
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Message-ID: <1317566760-25681-20-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the omap serial driver is built as a module, we must
not allow the console driver to be selected, because consoles
can not be loadable modules.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4dcb37bb..eb04b2f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1346,7 +1346,7 @@ config SERIAL_OMAP
 
 config SERIAL_OMAP_CONSOLE
 	bool "Console on OMAP serial port"
-	depends on SERIAL_OMAP
+	depends on SERIAL_OMAP=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Select this option if you would like to use omap serial port as
-- 
1.7.5.4
