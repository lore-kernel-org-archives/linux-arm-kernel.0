From: colin.king@canonical.com (Colin King)
Date: Fri, 21 Apr 2017 08:02:30 +0100
Subject: [PATCH] PCI: imx6: fix spelling mistake: "contol" -> "control"
Message-ID: <20170421070230.16582-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 102edcf1e261..129717ae5022 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -726,13 +726,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->pciephy_reset = devm_reset_control_get(dev,
 								  "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
-			dev_err(dev, "Failed to get PCIEPHY reset contol\n");
+			dev_err(dev, "Failed to get PCIEPHY reset control\n");
 			return PTR_ERR(imx6_pcie->pciephy_reset);
 		}
 
 		imx6_pcie->apps_reset = devm_reset_control_get(dev, "apps");
 		if (IS_ERR(imx6_pcie->apps_reset)) {
-			dev_err(dev, "Failed to get PCIE APPS reset contol\n");
+			dev_err(dev, "Failed to get PCIE APPS reset control\n");
 			return PTR_ERR(imx6_pcie->apps_reset);
 		}
 		break;
-- 
2.11.0
