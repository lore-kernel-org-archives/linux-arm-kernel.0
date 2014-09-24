From: b38611@freescale.com (Fugang Duan)
Date: Wed, 24 Sep 2014 10:11:18 +0800
Subject: [PATCH v1 1/3] ARM: imx6sx: add imx6sx iomux-gpr field define
In-Reply-To: <1411524680-12863-1-git-send-email-b38611@freescale.com>
References: <1411524680-12863-1-git-send-email-b38611@freescale.com>
Message-ID: <1411524680-12863-2-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx6sx iomux-gpr register field define in "imx6q-iomuxc-gpr.h" header
file, which is not fully define all iomux-gpr registers and fields, only
align with freescale internal tree related GPR macro define.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |   39 +++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index ff44374..c877cad 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -395,4 +395,43 @@
 #define IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK    (0x3 << 17)
 #define IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK    (0x1 << 14)
 
+/* For imx6sx iomux gpr register field define */
+#define IMX6SX_GPR1_VDEC_SW_RST_MASK			(0x1 << 20)
+#define IMX6SX_GPR1_VDEC_SW_RST_RESET			(0x1 << 20)
+#define IMX6SX_GPR1_VDEC_SW_RST_RELEASE			(0x0 << 20)
+#define IMX6SX_GPR1_VADC_SW_RST_MASK			(0x1 << 19)
+#define IMX6SX_GPR1_VADC_SW_RST_RESET			(0x1 << 19)
+#define IMX6SX_GPR1_VADC_SW_RST_RELEASE			(0x0 << 19)
+#define IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK		(0x3 << 13)
+#define IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK		(0x3 << 17)
+#define IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_EXT		(0x3 << 13)
+
+#define IMX6SX_GPR4_FEC_ENET1_STOP_REQ			(0x1 << 3)
+#define IMX6SX_GPR4_FEC_ENET2_STOP_REQ			(0x1 << 4)
+
+#define IMX6SX_GPR5_DISP_MUX_LDB_CTRL_MASK		(0x1 << 3)
+#define IMX6SX_GPR5_DISP_MUX_LDB_CTRL_LCDIF1		(0x0 << 3)
+#define IMX6SX_GPR5_DISP_MUX_LDB_CTRL_LCDIF2		(0x1 << 3)
+
+#define IMX6SX_GPR5_CSI2_MUX_CTRL_MASK			(0x3 << 27)
+#define IMX6SX_GPR5_CSI2_MUX_CTRL_EXT_PIN		(0x0 << 27)
+#define IMX6SX_GPR5_CSI2_MUX_CTRL_CVD			(0x1 << 27)
+#define IMX6SX_GPR5_CSI2_MUX_CTRL_VDAC_TO_CSI		(0x2 << 27)
+#define IMX6SX_GPR5_CSI2_MUX_CTRL_GND			(0x3 << 27)
+#define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_MASK		(0x1 << 26)
+#define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_ENABLE	(0x1 << 26)
+#define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_DISABLE	(0x0 << 26)
+#define IMX6SX_GPR5_CSI1_MUX_CTRL_MASK			(0x3 << 4)
+#define IMX6SX_GPR5_CSI1_MUX_CTRL_EXT_PIN		(0x0 << 4)
+#define IMX6SX_GPR5_CSI1_MUX_CTRL_CVD			(0x1 << 4)
+#define IMX6SX_GPR5_CSI1_MUX_CTRL_VDAC_TO_CSI		(0x2 << 4)
+#define IMX6SX_GPR5_CSI1_MUX_CTRL_GND			(0x3 << 4)
+
+#define IMX6SX_GPR5_DISP_MUX_DCIC2_LCDIF2		(0x0 << 2)
+#define IMX6SX_GPR5_DISP_MUX_DCIC2_LVDS			(0x1 << 2)
+#define IMX6SX_GPR5_DISP_MUX_DCIC2_MASK			(0x1 << 2)
+#define IMX6SX_GPR5_DISP_MUX_DCIC1_LCDIF1		(0x0 << 1)
+#define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
+#define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
+
 #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
-- 
1.7.8
