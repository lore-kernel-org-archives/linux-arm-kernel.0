From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Mon, 29 Sep 2014 15:59:20 +0200
Subject: [PATCH RESEND] serial: mxs-auart: add sysrq support
In-Reply-To: <1411999160-26804-1-git-send-email-j.uzycki@elproma.com.pl>
References: <Re: [PATCH] serial: mxs-auart: add sysrq support>
 <1411999160-26804-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <1411999160-26804-2-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using mxs-auart based console, sometime we need the sysrq function
to help debugging kernel. The sysrq code is basically there,
this patch just simply enable it.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 9381732..4c998a3 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -14,6 +14,10 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#if defined(CONFIG_SERIAL_MXS_AUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-- 
1.7.11.3
