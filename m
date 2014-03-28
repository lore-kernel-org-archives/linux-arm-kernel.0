From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Mar 2014 17:52:56 +0100
Subject: [PATCH 5/8] PCI: imx6: drop old irq mapping
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1396025579-14344-6-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need this anymore. The irqs are now
properly mapped through the DT.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 71730bbcd9a2..259a73687526 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -483,12 +483,6 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 {
 	int ret;
 
-	pp->irq = platform_get_irq(pdev, 0);
-	if (!pp->irq) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return -ENODEV;
-	}
-
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
-- 
1.9.0
