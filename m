From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:11:14 +0530
Subject: [PATCH v2 21/21] PCI: keystone: Cleanup macros defined in
 pci-keystone.c
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-22-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Cleanup macros defined in pci-keystone.c
by removing unused macros, grouping the macros and aligning
it properly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 41 +++++++++--------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 0cfeaad1d013..14f2b0b4ed5e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -28,21 +28,14 @@
 
 #include "pcie-designware.h"
 
-#define DRIVER_NAME	"keystone-pcie"
-
 #define PCIE_VENDORID_MASK	0xffff
 #define PCIE_DEVICEID_SHIFT	16
 
-/* DEV_STAT_CTRL */
-#define PCIE_CAP_BASE		0x70
-
-/* Application register defines */
-#define LTSSM_EN_VAL		        BIT(0)
-#define DBI_CS2				BIT(5)
-#define OB_XLAT_EN_VAL		        BIT(1)
-
 /* Application registers */
 #define CMD_STATUS			0x004
+#define LTSSM_EN_VAL		        BIT(0)
+#define OB_XLAT_EN_VAL		        BIT(1)
+#define DBI_CS2				BIT(5)
 
 #define CFG_SETUP			0x008
 #define CFG_BUS(x)			(((x) & 0xff) << 16)
@@ -70,27 +63,25 @@
 #define IRQ_STATUS			0x184
 #define MSI_IRQ_OFFSET			4
 
-/* Error IRQ bits */
-#define ERR_AER		BIT(5)	/* ECRC error */
-#define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
-#define ERR_CORR	BIT(3)	/* Correctable error */
-#define ERR_NONFATAL	BIT(2)	/* Non-fatal error */
-#define ERR_FATAL	BIT(1)	/* Fatal error */
-#define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
-#define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
-			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
-#define ERR_IRQ_ENABLE_CLR		0x1cc
+#define ERR_AER				BIT(5)	/* ECRC error */
+#define ERR_AXI				BIT(4)	/* AXI tag lookup fatal error */
+#define ERR_CORR			BIT(3)	/* Correctable error */
+#define ERR_NONFATAL			BIT(2)	/* Non-fatal error */
+#define ERR_FATAL			BIT(1)	/* Fatal error */
+#define ERR_SYS				BIT(0)	/* System error */
+#define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
+					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
 #define MAX_MSI_HOST_IRQS		8
 /* PCIE controller device IDs */
-#define PCIE_RC_K2HK		0xb008
-#define PCIE_RC_K2E		0xb009
-#define PCIE_RC_K2L		0xb00a
-#define PCIE_RC_K2G		0xb00b
+#define PCIE_RC_K2HK			0xb008
+#define PCIE_RC_K2E			0xb009
+#define PCIE_RC_K2L			0xb00a
+#define PCIE_RC_K2G			0xb00b
 
-#define to_keystone_pcie(x)	dev_get_drvdata((x)->dev)
+#define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
 struct keystone_pcie {
 	struct dw_pcie		*pci;
-- 
2.17.1
