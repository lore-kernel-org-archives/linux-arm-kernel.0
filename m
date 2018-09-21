From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:38 +0530
Subject: [RFC PATCH 23/40] PCI: keystone: Cleanup macros defined in
 pci-keystone.c
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-24-kishon@ti.com>
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
index b1dfaea29530..75d007148804 100644
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
@@ -65,18 +58,16 @@
 #define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
 #define INTx_EN				BIT(0)
 
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
 
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_ENABLEN			BIT(0)
@@ -84,12 +75,12 @@
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
 
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
 
 static int ks_pcie_start_link(struct dw_pcie *pci);
 static void ks_pcie_stop_link(struct dw_pcie *pci);
-- 
2.17.1
