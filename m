From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 17 Nov 2018 10:12:23 -0800
Subject: [PATCH 1/3] PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
In-Reply-To: <20181117181225.10737-1-andrew.smirnov@gmail.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
Message-ID: <20181117181225.10737-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll()
is applicable.

Cc: bhelgaas at google.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy at gmail.com
Cc: l.stach at pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx at nxp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-pci at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2cbef2d7c207..c140f7987598 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -525,6 +525,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (imx6_pcie->variant == IMX7D)
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
-- 
2.19.1
