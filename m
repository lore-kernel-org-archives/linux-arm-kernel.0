From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:31:00 +0100
Subject: [RFC PATCH 05/15] tty: serial: samsung: fixup accessors for endian
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-6-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the serial access code to deal with kernels built for big endian
operation.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
---
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial at vger.kernel.org
CC: linux-kernel at vger.kernel.org
---
 drivers/tty/serial/samsung.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index fc5deaa..8818bdd 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -118,9 +118,9 @@ struct s3c24xx_uart_port {
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
 #define rd_regb(port, reg) (__raw_readb(portaddr(port, reg)))
-#define rd_regl(port, reg) (__raw_readl(portaddr(port, reg)))
+#define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
 
 #define wr_regb(port, reg, val) __raw_writeb(val, portaddr(port, reg))
-#define wr_regl(port, reg, val) __raw_writel(val, portaddr(port, reg))
+#define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
 
 #endif
-- 
2.8.3
