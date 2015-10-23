From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 23 Oct 2015 18:00:00 +0800
Subject: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()"
Message-ID: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 71a5cd8a4 makes the console hang for some times.
This reverts commit 71a5cd8a4a2602a6e9010b557a23af0a54df87b6.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 899a771..fd27e98 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -191,8 +191,8 @@ struct uart_amba_port {
  */
 static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 {
-	u16 status;
-	unsigned int ch, flag, max_count = 256;
+	u16 status, ch;
+	unsigned int flag, max_count = 256;
 	int fifotaken = 0;
 
 	while (max_count--) {
-- 
2.1.4
