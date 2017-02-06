From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  6 Feb 2017 07:17:14 -0800
Subject: [PATCH v3 1/3] PCI: imx6: Fix a typo in error message
In-Reply-To: <20170206151716.10381-1-andrew.smirnov@gmail.com>
References: <20170206151716.10381-1-andrew.smirnov@gmail.com>
Message-ID: <20170206151716.10381-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: yurovsky at gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org

Acked-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/host/pci-imx6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index c8cefb0..50a1291 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -678,8 +678,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
 		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
-			dev_err(dev,
-				"pcie_incbound_axi clock missing or invalid\n");
+			dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
 	}
-- 
2.9.3
