From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 14 Aug 2018 19:50:17 +0300
Subject: [PATCH v4 3/6] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
Message-ID: <88a5997e37d048cfc2dabb44cc13dce89c93d5eb.1534264292.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required for the imx pci driver to send the PME_Turn_Off TLP.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/reset/reset-imx7.c             | 1 +
 include/dt-bindings/reset/imx7-reset.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 97d9f08271c5..77911fa8f31d 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -65,10 +65,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_MIPI_PHY_MRST]	= { SRC_MIPIPHY_RCR, BIT(1) },
 	[IMX7_RESET_MIPI_PHY_SRST]	= { SRC_MIPIPHY_RCR, BIT(2) },
 	[IMX7_RESET_PCIEPHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
 	[IMX7_RESET_PCIEPHY_PERST]	= { SRC_PCIEPHY_RCR, BIT(3) },
 	[IMX7_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] = { SRC_PCIEPHY_RCR, BIT(11) },
 	[IMX7_RESET_DDRC_PRST]		= { SRC_DDRC_RCR, BIT(0) },
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
index 63948170c7b2..31b3f87dde9a 100644
--- a/include/dt-bindings/reset/imx7-reset.h
+++ b/include/dt-bindings/reset/imx7-reset.h
@@ -54,9 +54,11 @@
  */
 #define IMX7_RESET_PCIE_CTRL_APPS_EN	22
 #define IMX7_RESET_DDRC_PRST		23
 #define IMX7_RESET_DDRC_CORE_RST	24
 
-#define IMX7_RESET_NUM			25
+#define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
+
+#define IMX7_RESET_NUM			26
 
 #endif
 
-- 
2.17.1
