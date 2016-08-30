From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 30 Aug 2016 16:09:17 +0530
Subject: [PATCH 2/3] PCI: Xilinx NWL PCIe: Enabling all MSI interrupts using
 MSI mask.
In-Reply-To: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1472553558-27215-2-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current mask enables and allows only one MSI interrupt on each MSI line.
This change, enables all MSI interrupts, which will also support End Points
with multi MSI support.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 86c1834..d8d43e6 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -120,8 +120,8 @@
 					MSGF_LEG_SR_INTC | MSGF_LEG_SR_INTD)
 
 /* MSI interrupt status mask bits */
-#define MSGF_MSI_SR_LO_MASK		BIT(0)
-#define MSGF_MSI_SR_HI_MASK		BIT(0)
+#define MSGF_MSI_SR_LO_MASK		GENMASK(31, 0)
+#define MSGF_MSI_SR_HI_MASK		GENMASK(31, 0)
 
 #define MSII_PRESENT			BIT(0)
 #define MSII_ENABLE			BIT(0)
-- 
2.1.1
