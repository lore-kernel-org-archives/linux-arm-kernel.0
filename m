From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 17:35:29 +0100
Subject: [PATCH v2 1/2] PCI: armada8k: Remove useless test before
 clk_disable_unprepare
In-Reply-To: <20180228163530.25389-1-gregory.clement@bootlin.com>
References: <20180228163530.25389-1-gregory.clement@bootlin.com>
Message-ID: <20180228163530.25389-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index b587352f8b9f..f9b1aec25c5c 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -247,8 +247,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
-	if (!IS_ERR(pcie->clk))
-		clk_disable_unprepare(pcie->clk);
+	clk_disable_unprepare(pcie->clk);
 
 	return ret;
 }
-- 
2.16.1
