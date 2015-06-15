From: Richard.Zhu@freescale.com (Zhu Richard)
Date: Mon, 15 Jun 2015 09:28:23 +0000
Subject: [PATCH] PCI: imx6: Use "u32", not "uint32_t"
In-Reply-To: <20150612202357.17586.99216.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150612202357.17586.99216.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <DM2PR0301MB086229F4742DB3020E66EDFAF7B80@DM2PR0301MB0862.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks, to let it consistence.

Acked-by: Richard Zhu <Richard.Zhu@freescale.com>

Freescale Linux BSP team
Best Regards
Richard Zhu

-----Original Message-----
From: Bjorn Helgaas [mailto:bhelgaas at google.com] 
Sent: Saturday, June 13, 2015 4:24 AM
To: Zhu Richard-R65037; Lucas Stach
Cc: Marek Vasut; linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Troy Kisky
Subject: [PATCH] PCI: imx6: Use "u32", not "uint32_t"

Use "u32", not "uint32_t", for consistency.  Use "tmp", not "temp", for consistency within the driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c index 2bbd38d..a032c01 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -354,7 +354,7 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 
 static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)  {
-	uint32_t tmp;
+	u32 tmp;
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++) @@ -379,7 +379,7 @@ static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)  static int imx6_pcie_start_link(struct pcie_port *pp)  {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
-	uint32_t tmp;
+	u32 tmp;
 	int ret;
 
 	/*
@@ -450,19 +450,19 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)  {
-	uint32_t temp;
+	u32 tmp;
 
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
-	temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		 PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
-	temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
 }
 
 static int imx6_pcie_link_up(struct pcie_port *pp)
