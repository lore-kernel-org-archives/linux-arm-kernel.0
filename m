From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 20 Nov 2018 09:26:00 +0000
Subject: [PATCHv2 04/25] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181120092615.11680-5-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current code does not support multiple MSIs, so remove
the corresponding flag from the msi_domain_info structure.

Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Added fixes entry.

 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 563210e731d3..a0dd337c6214 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip = {
 
 static struct msi_domain_info mobiveil_msi_domain_info = {
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_PCI_MSIX),
 	.chip	= &mobiveil_msi_irq_chip,
 };
 
-- 
2.17.1
