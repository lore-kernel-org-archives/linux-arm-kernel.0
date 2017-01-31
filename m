From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 31 Jan 2017 14:29:30 +0530
Subject: [PATCH] PCI: Xilinx NWL: Remove mask for messages not supported by AXI
Message-ID: <1485853170-31940-1-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Removing support for vendor defined messages which are not
suppoerted by AXI

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 76dd094..651486a 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -62,21 +62,9 @@
 #define CFG_ENABLE_PM_MSG_FWD		BIT(1)
 #define CFG_ENABLE_INT_MSG_FWD		BIT(2)
 #define CFG_ENABLE_ERR_MSG_FWD		BIT(3)
-#define CFG_ENABLE_SLT_MSG_FWD		BIT(5)
-#define CFG_ENABLE_VEN_MSG_FWD		BIT(7)
-#define CFG_ENABLE_OTH_MSG_FWD		BIT(13)
-#define CFG_ENABLE_VEN_MSG_EN		BIT(14)
-#define CFG_ENABLE_VEN_MSG_VEN_INV	BIT(15)
-#define CFG_ENABLE_VEN_MSG_VEN_ID	GENMASK(31, 16)
 #define CFG_ENABLE_MSG_FILTER_MASK	(CFG_ENABLE_PM_MSG_FWD | \
 					CFG_ENABLE_INT_MSG_FWD | \
-					CFG_ENABLE_ERR_MSG_FWD | \
-					CFG_ENABLE_SLT_MSG_FWD | \
-					CFG_ENABLE_VEN_MSG_FWD | \
-					CFG_ENABLE_OTH_MSG_FWD | \
-					CFG_ENABLE_VEN_MSG_EN | \
-					CFG_ENABLE_VEN_MSG_VEN_INV | \
-					CFG_ENABLE_VEN_MSG_VEN_ID)
+					CFG_ENABLE_ERR_MSG_FWD)
 
 /* Misc interrupt status mask bits */
 #define MSGF_MISC_SR_RXMSG_AVAIL	BIT(0)
-- 
1.7.1
