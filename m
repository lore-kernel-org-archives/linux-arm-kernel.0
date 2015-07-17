From: b38611@freescale.com (Fugang Duan)
Date: Fri, 17 Jul 2015 16:38:21 +0800
Subject: [PATCH v1 1/4] ARM: imx6ul: add fec bits to GPR syscon definition
In-Reply-To: <1437122304-20598-1-git-send-email-b38611@freescale.com>
References: <1437122304-20598-1-git-send-email-b38611@freescale.com>
Message-ID: <1437122304-20598-2-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC requires additional bits to select refrence clock.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index d16f4c8..558a485 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -435,4 +435,12 @@
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
 
+/* For imx6ul iomux gpr register field define */
+#define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
+#define IMX6UL_GPR1_ENET2_CLK_DIR		(0x1 << 18)
+#define IMX6UL_GPR1_ENET1_CLK_OUTPUT		(0x1 << 17)
+#define IMX6UL_GPR1_ENET2_CLK_OUTPUT		(0x1 << 18)
+#define IMX6UL_GPR1_ENET_CLK_DIR		(0x3 << 17)
+#define IMX6UL_GPR1_ENET_CLK_OUTPUT		(0x3 << 17)
+
 #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
-- 
1.9.1
