From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 13 Jul 2017 18:35:27 +0800
Subject: [PATCH] PCI: dwc: designware: test PCIE_ATU_ENABLE bit to check
 enabled or not
Message-ID: <20170713103527.1642-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ATU CTRL2 register is 32 bit, besides the enable bit, other bits
may also be set. To check whether the ATU is enabled or not, we should
test the enable it.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 0e03af279259..6bf0b409050a 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -177,7 +177,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
 		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
-		if (val == PCIE_ATU_ENABLE)
+		if (val & PCIE_ATU_ENABLE)
 			return;
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
-- 
2.13.2
