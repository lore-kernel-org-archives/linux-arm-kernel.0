From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri, 29 Jun 2018 11:10:05 +0200
Subject: [PATCH 1/3] PCI: mvebu: Remove redundant platform_set_drvdata() call
In-Reply-To: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
References: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180629091007.31069-2-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is already done earlier in mvebu_pcie_probe().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 358b56ba7c37..0e729bab14c0 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1115,8 +1115,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	mvebu_pcie_enable(pcie);
 
-	platform_set_drvdata(pdev, pcie);
-
 	return 0;
 }
 
-- 
2.14.4
