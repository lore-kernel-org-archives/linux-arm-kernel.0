From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 09 Oct 2017 19:44:38 +0530
Subject: [PATCH] PCI: exynos: remove redundant code in
 exynos_pcie_establish_link
References: <CGME20171009141438epcas2p4ead7e2f2d1af7e0950f2c026e3a9943b@epcas2p4.samsung.com>
Message-ID: <1507558478-3218-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anvesh Salveru <anvesh.s@samsung.com>

In exynos_pcie_establish_link if driver is not using generic phy,
we are resetting PHY twice, which is redundant, so this patch removes
repeated lines of code for PHY reset.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
---
 drivers/pci/dwc/pci-exynos.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 5596fde..85d2f4b 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -423,13 +423,6 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
 		exynos_pcie_deassert_phy_reset(ep);
 		exynos_pcie_power_on_phy(ep);
 		exynos_pcie_init_phy(ep);
-
-		/* pulse for common reset */
-		exynos_pcie_writel(ep->mem_res->block_base, 1,
-					PCIE_PHY_COMMON_RESET);
-		udelay(500);
-		exynos_pcie_writel(ep->mem_res->block_base, 0,
-					PCIE_PHY_COMMON_RESET);
 	}
 
 	/* pulse for common reset */
-- 
2.7.4
