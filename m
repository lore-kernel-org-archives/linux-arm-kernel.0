From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 12 Jan 2017 15:56:12 +0530
Subject: [PATCH 23/37] PCI: dwc: Add *ops* to start and stop pcie link
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
Message-ID: <1484216786-17292-24-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add start_link and stop_link ops in dw_pcie_ops to start or stop
the link. This will be used by endpoint functions to start the
link once the setup has been done.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 0ef6ae7..25b3b8b 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -149,6 +149,8 @@ struct dw_pcie_ops {
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			     int size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
+	int	(*start_link)(struct dw_pcie *pcie);
+	void	(*stop_link)(struct dw_pcie *pcie);
 };
 
 struct dw_pcie {
-- 
1.7.9.5
