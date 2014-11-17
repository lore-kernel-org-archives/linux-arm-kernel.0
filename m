From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 17 Nov 2014 18:07:39 +0300
Subject: [PATCH V2 1/5] serial: pxa: prepare/unprepare clocks
Message-ID: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unprepare().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/tty/serial/pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 21b7d8b8..2f4c329 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -647,7 +647,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-	clk_enable(up->clk);
+	clk_prepare_enable(up->clk);
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
@@ -674,7 +674,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
-	clk_disable(up->clk);
+	clk_disable_unprepare(up->clk);
 
 }
 
-- 
2.1.1
