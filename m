From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 16:33:48 +0100
Subject: [PATCH 06/24] xen: missing includes
In-Reply-To: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
Message-ID: <1343316846-25860-6-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/tty/hvc/hvc_xen.c                  |    2 ++
 drivers/xen/grant-table.c                  |    1 +
 drivers/xen/xenbus/xenbus_probe_frontend.c |    1 +
 include/xen/interface/xen.h                |    3 +++
 include/xen/privcmd.h                      |    1 +
 5 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 944eaeb..dc07f56 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -21,6 +21,7 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/list.h>
@@ -35,6 +36,7 @@
 #include <xen/page.h>
 #include <xen/events.h>
 #include <xen/interface/io/console.h>
+#include <xen/interface/sched.h>
 #include <xen/hvc-console.h>
 #include <xen/xenbus.h>
 
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 0bfc1ef..1d0d95e 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -47,6 +47,7 @@
 #include <xen/interface/memory.h>
 #include <xen/hvc-console.h>
 #include <asm/xen/hypercall.h>
+#include <asm/xen/interface.h>
 
 #include <asm/pgtable.h>
 #include <asm/sync_bitops.h>
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index a31b54d..3159a37 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -21,6 +21,7 @@
 #include <xen/xenbus.h>
 #include <xen/events.h>
 #include <xen/page.h>
+#include <xen/xen.h>
 
 #include <xen/platform_pci.h>
 
diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index a890804..4f29f33 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -10,7 +10,10 @@
 #define __XEN_PUBLIC_XEN_H__
 
 #include <asm/xen/interface.h>
+#include <linux/types.h>
+#ifdef CONFIG_X86
 #include <asm/pvclock-abi.h>
+#endif
 
 /*
  * XEN "SYSTEM CALLS" (a.k.a. HYPERCALLS).
diff --git a/include/xen/privcmd.h b/include/xen/privcmd.h
index 17857fb..4d58881 100644
--- a/include/xen/privcmd.h
+++ b/include/xen/privcmd.h
@@ -35,6 +35,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <xen/interface/xen.h>
 
 typedef unsigned long xen_pfn_t;
 
-- 
1.7.2.5
