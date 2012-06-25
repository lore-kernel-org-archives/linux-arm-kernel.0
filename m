From: dhowells@redhat.com (David Howells)
Date: Mon, 25 Jun 2012 20:11:31 +0100
Subject: [PATCH] ARM: Delete asm/system.h
Message-ID: <20120625191130.27109.42551.stgit@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete asm/system.h from the ARM arch.  This was missed when the others were
deleted.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/arm/include/asm/jump_label.h |    1 -
 arch/arm/include/asm/system.h     |    8 --------
 arch/arm/mach-msm/idle.c          |    2 +-
 arch/arm/plat-omap/mux.c          |    2 --
 drivers/usb/gadget/lpc32xx_udc.c  |    1 -
 5 files changed, 1 insertions(+), 13 deletions(-)
 delete mode 100644 arch/arm/include/asm/system.h

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index bfc198c..f0409ec 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -4,7 +4,6 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
-#include <asm/system.h>
 
 #define JUMP_LABEL_NOP_SIZE 4
 
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
deleted file mode 100644
index 74542c5..0000000
--- a/arch/arm/include/asm/system.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* FILE TO BE DELETED. DO NOT ADD STUFF HERE! */
-#include <asm/barrier.h>
-#include <asm/compiler.h>
-#include <asm/cmpxchg.h>
-#include <asm/exec.h>
-#include <asm/switch_to.h>
-#include <asm/system_info.h>
-#include <asm/system_misc.h>
diff --git a/arch/arm/mach-msm/idle.c b/arch/arm/mach-msm/idle.c
index 0c9e13c..e4d0c66 100644
--- a/arch/arm/mach-msm/idle.c
+++ b/arch/arm/mach-msm/idle.c
@@ -17,7 +17,7 @@
  */
 
 #include <linux/init.h>
-#include <asm/system.h>
+#include <asm/system_misc.h>
 
 static void msm_idle(void)
 {
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index cff8712..da503eb 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -28,8 +28,6 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 
-#include <asm/system.h>
-
 #include <plat/cpu.h>
 #include <plat/mux.h>
 
diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
index 262acfd..626963e 100644
--- a/drivers/usb/gadget/lpc32xx_udc.c
+++ b/drivers/usb/gadget/lpc32xx_udc.c
@@ -55,7 +55,6 @@
 #include <mach/hardware.h>
 #include <linux/io.h>
 #include <asm/irq.h>
-#include <asm/system.h>
 
 #include <mach/platform.h>
 #include <mach/irqs.h>
