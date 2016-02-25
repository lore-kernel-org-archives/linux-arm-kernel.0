From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Thu, 25 Feb 2016 15:47:48 +0100
Subject: [PATCH v3 1/2] MFD: imx6sx: Add PCIe register definitions for iomuxc
 gpr
In-Reply-To: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1456411669-4699-2-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds macros to define masks and bits for imx6sx
PCIe registers. This is based on a patch by Richard Zhu.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index 558a485..238c8db 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -422,6 +422,7 @@
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_MASK		(0x1 << 26)
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_ENABLE	(0x1 << 26)
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_DISABLE	(0x0 << 26)
+#define IMX6SX_GPR5_PCIE_BTNRST_RESET			BIT(19)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_MASK			(0x3 << 4)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_EXT_PIN		(0x0 << 4)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_CVD			(0x1 << 4)
@@ -435,6 +436,10 @@
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
 
+#define IMX6SX_GPR12_PCIE_TEST_POWERDOWN		BIT(30)
+#define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)
+#define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)
+
 /* For imx6ul iomux gpr register field define */
 #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
 #define IMX6UL_GPR1_ENET2_CLK_DIR		(0x1 << 18)
-- 
2.1.4
