From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 20 Nov 2018 09:27:02 +0000
Subject: [PATCHv2 14/25] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181120092615.11680-15-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The reset value is all zero, so set a workable value for Primary,
Secondary and Subordinate bus numbers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index db7ecb021c63..9210165fe8c0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
 
+	/* setup bus numbers */
+	value = csr_readl(pcie, PCI_PRIMARY_BUS);
+	value &= 0xff000000;
+	value |= 0x00ff0100;
+	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
-- 
2.17.1
