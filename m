From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 18:07:02 +0800
Subject: [PATCH v2 1/2] PCI: designware: mv parameters for wait for link into
 pcie-designware.c
In-Reply-To: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
References: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470823623-1360-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These parameters are only used in the core pcie-designware.c, let's
move them to the core driver.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pcie-designware.c | 5 +++++
 drivers/pci/host/pcie-designware.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..24a16dd 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -75,6 +75,11 @@
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
 
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_USLEEP_MIN		90000
+#define LINK_WAIT_USLEEP_MAX		100000
+
 static struct pci_ops dw_pcie_ops;
 
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f437f9b..384e79b 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,11 +22,6 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
-
 struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;
-- 
2.8.1
