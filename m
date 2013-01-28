From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 19:56:18 +0100
Subject: [PATCH v2 09/27] pci: infrastructure to add drivers in
 drivers/pci/host
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1359399397-29729-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As agreed by the community, PCI host drivers will now be stored in
drivers/pci/host. This commit adds this directory and the related
Kconfig/Makefile changes to allow new drivers to be added in this
directory.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/Kconfig      |    2 ++
 drivers/pci/Makefile     |    3 +++
 drivers/pci/host/Kconfig |    4 ++++
 3 files changed, 9 insertions(+)
 create mode 100644 drivers/pci/host/Kconfig

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 6ed3db1..45392ab 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -125,3 +125,5 @@ config PCI_SW_HOST_BRIDGE
 
 config PCI_SW_PCI_PCI_BRIDGE
 	bool
+
+source "drivers/pci/host/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 5b48961..eae4db1 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -71,3 +71,6 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_OF) += of.o
 
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
+
+# PCI host controller drivers
+obj-y += host/
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
new file mode 100644
index 0000000..cc3a1af
--- /dev/null
+++ b/drivers/pci/host/Kconfig
@@ -0,0 +1,4 @@
+menu "PCI host controller drivers"
+	depends on PCI
+
+endmenu
-- 
1.7.9.5
