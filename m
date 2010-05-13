From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 13 May 2010 20:47:34 +0300
Subject: [PATCH 13/15] omap: mailbox: reorganize headers
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1273772856-10881-14-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c             |    5 +----
 arch/arm/mach-omap2/mailbox.c             |    7 +++----
 arch/arm/plat-omap/include/plat/mailbox.h |    3 ---
 arch/arm/plat-omap/mailbox.c              |    6 +++---
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 036e159..8eea651 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -9,13 +9,10 @@
  * for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/resource.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+
 #include <plat/mailbox.h>
-#include <mach/irqs.h>
 
 #define MAILBOX_ARM2DSP1		0x00
 #define MAILBOX_ARM2DSP1b		0x04
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 7abd159..2817103 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -10,13 +10,12 @@
  * for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/err.h>
+
 #include <plat/mailbox.h>
-#include <mach/irqs.h>
 
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_SYSCONFIG		0x010
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index cfbe221..fe30dc5 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -3,9 +3,6 @@
 #ifndef MAILBOX_H
 #define MAILBOX_H
 
-#include <linux/wait.h>
-#include <linux/workqueue.h>
-#include <linux/blkdev.h>
 #include <linux/interrupt.h>
 
 typedef u32 mbox_msg_t;
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 7ccd1e7..2727e52 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -21,11 +21,11 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
+#include <linux/spinlock_types.h>
+#include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/blkdev.h>
 
 #include <plat/mailbox.h>
 
-- 
1.7.1
