From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 02:18:25 +0100
Subject: [PATCH 03/15] serial: sh-sci: Restrict non-COMPILE_TEST compilation
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1385515117-23664-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware supported by the driver is only found on SUPERH or
ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST compilation to them.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3817ab..a640d0b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -709,7 +709,8 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
+	depends on HAVE_CLK
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
1.8.3.2
