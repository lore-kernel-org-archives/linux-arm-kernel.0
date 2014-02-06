From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:47:39 +0900
Subject: [PATCH 1/2] serial: sh-sci: Restrict non-COMPILE_TEST compilation
In-Reply-To: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
References: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1391669260-23970-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hardware supported by the driver is only found on SUPERH or
ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST compilation to them.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3815ea..923d3de 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -708,7 +708,8 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
+	depends on HAVE_CLK
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
1.8.5.2
