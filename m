From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri,  3 Aug 2018 16:38:43 +0200
Subject: [PATCH v2 1/6] PCI: mvebu: Remove redundant platform_set_drvdata()
 call
In-Reply-To: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
References: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180803143848.21551-2-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is already done earlier in mvebu_pcie_probe().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 23e270839e6a..38fa2d08527d 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1283,8 +1283,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	mvebu_pcie_enable(pcie);
 
-	platform_set_drvdata(pdev, pcie);
-
 	return 0;
 }
 
-- 
2.14.4
