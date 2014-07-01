From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Jul 2014 22:37:04 +0200
Subject: [PATCH 1/3] serial: DC21285: depend on ARCH_FOOTBRIDGE instead of
 FOOTBRIDGE
In-Reply-To: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1404247026-379-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol FOOTBRIDGE is only defined if ARCH_FOOTBRIDGE is
enabled and the latter unconditionally selects the former. So they are
either both selected or none and so they are equivalent. To allow
removing FOOTBRIDGE switch the dependency of SERIAL_21285 to
ARCH_FOOTBRIDGE.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fb57159bad3a..570ca2ff55d1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -380,7 +380,7 @@ config SERIAL_ZS_CONSOLE
 
 config SERIAL_21285
 	tristate "DC21285 serial port support"
-	depends on FOOTBRIDGE
+	depends on ARCH_FOOTBRIDGE
 	select SERIAL_CORE
 	help
 	  If you have a machine based on a 21285 (Footbridge) StrongARM(R)/
-- 
2.0.0
