From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  3 May 2012 11:37:12 +0200
Subject: [PATCH] Add missing call to uart_update_timeout()
Message-ID: <1336037832-16060-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a problem reported here:
http://article.gmane.org/gmane.linux.ports.arm.kernel/155242/match=auart

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/tty/serial/mxs-auart.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 55fd362..039c054 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -369,6 +369,8 @@ static void mxs_auart_settermios(struct uart_port *u,
 
 	writel(ctrl, u->membase + AUART_LINECTRL);
 	writel(ctrl2, u->membase + AUART_CTRL2);
+
+	uart_update_timeout(u, termios->c_cflag, baud);
 }
 
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
-- 
1.7.2.5
