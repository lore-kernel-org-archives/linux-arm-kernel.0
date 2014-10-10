From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Fri, 10 Oct 2014 13:13:28 +0200
Subject: [PATCH v2 RESEND] serial: mxs-auart: add sysrq support
Message-ID: <1412939608-19933-1-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using mxs-auart based console, sometime we need the sysrq function
to help debugging kernel. The sysrq code is basically there,
this patch just simply enable it.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
Changes from v1 (the initial version of the patch):
* the patch was extracted as indendent from my previous patchset
  "serial: mxs-auart: use mctrl_gpio helpers for handling modem signals (v2.2c)"
   "[PATCH 4/4] serial: mxs-auart: add sysrq support"
* removed obvious comment about required order of
  SUPPORT_SYSRQ define and serial_core.h include

The patch is resent as ready to apply.

I resend it again because last time
in conver letter I swapped subject with
in-reply-to and the patch could be omited.
This time I've added versioning and changelog.

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
