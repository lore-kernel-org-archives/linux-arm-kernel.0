From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 22:56:43 +0100
Subject: [PATCH] vfio: include <linux/slab.h> for kmalloc
In-Reply-To: <1363298204-8014-1-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
Message-ID: <1363298204-8014-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vfio drivers call kmalloc or kzalloc, but do not
include <linux/slab.h>, which causes build errors on
ARM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm at vger.kernel.org
---
Please apply for 3.9

 drivers/vfio/pci/vfio_pci_config.c | 1 +
 drivers/vfio/pci/vfio_pci_intrs.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 964ff22..aeb00fc 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
+#include <linux/slab.h>
 
 #include "vfio_pci_private.h"
 
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 3639371..a965091 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -22,6 +22,7 @@
 #include <linux/vfio.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/slab.h>
 
 #include "vfio_pci_private.h"
 
-- 
1.8.1.2
