From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:23:56 +0200
Subject: [PATCH RFC 11/11] watchdog: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Message-ID: <1400163836-9831-16-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog at vger.kernel.org
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 74ec8fc5cc03..e68f2b9a3b31 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -301,7 +301,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
+	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
-- 
2.0.0.rc2
