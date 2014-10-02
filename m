From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Thu,  2 Oct 2014 20:11:36 +0200
Subject: [PATCH RESEND] serial: mxs-auart: add sysrq support
In-Reply-To: <1412273496-10610-1-git-send-email-j.uzycki@elproma.com.pl>
References: <20140929014129.GA8687@kroah.com>
 <1412273496-10610-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <1412273496-10610-2-git-send-email-j.uzycki@elproma.com.pl>
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
index eafce41..e838e84 100644
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
