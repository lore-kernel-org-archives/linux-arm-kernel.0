From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Aug 2017 02:38:43 +0200
Subject: [PATCH 1/5] dt-bindings: reset: Add Realtek RTD1295
In-Reply-To: <20170816003847.6208-1-afaerber@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
Message-ID: <20170816003847.6208-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding for Realtek RTD1295 reset controller.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../bindings/reset/realtek,rtd129x-reset.txt       |  18 ++++
 include/dt-bindings/reset/realtek,rtd1295.h        | 112 +++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/realtek,rtd129x-reset.txt
 create mode 100644 include/dt-bindings/reset/realtek,rtd1295.h

diff --git a/Documentation/devicetree/bindings/reset/realtek,rtd129x-reset.txt b/Documentation/devicetree/bindings/reset/realtek,rtd129x-reset.txt
new file mode 100644
index 000000000000..79fb37feb0a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/realtek,rtd129x-reset.txt
@@ -0,0 +1,18 @@
+Realtek RTD129x Reset Controller
+================================
+
+Required properties:
+- compatible   :  Should be "realtek,rtd1295-reset"
+- reg          :  Should contain the register address and 4 as size.
+- #reset-cells :  Should be 1
+
+See reset.txt for common reset controller bindings.
+
+
+Example:
+
+	reset-controller at 98000000 {
+		compatible = "realtek,rtd1295-reset";
+		reg = <0x98000000 0x4>;
+		#reset-cells = <1>;
+	};
diff --git a/include/dt-bindings/reset/realtek,rtd1295.h b/include/dt-bindings/reset/realtek,rtd1295.h
new file mode 100644
index 000000000000..237b3ff6697e
--- /dev/null
+++ b/include/dt-bindings/reset/realtek,rtd1295.h
@@ -0,0 +1,112 @@
+/*
+ * Realtek RTD1295 reset controllers
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+#ifndef DT_BINDINGS_RESET_RTD1295_H
+#define DT_BINDINGS_RESET_RTD1295_H
+
+/* soft reset 1 */
+#define RTD1295_RSTN_MISC		0
+#define RTD1295_RSTN_NAT		1
+#define RTD1295_RSTN_USB3_PHY0_POW	2
+#define RTD1295_RSTN_GSPI		3
+#define RTD1295_RSTN_USB3_P0_MDIO	4
+#define RTD1295_RSTN_SATA_0		5
+#define RTD1295_RSTN_USB		6
+#define RTD1295_RSTN_SATA_PHY_0		7
+#define RTD1295_RSTN_USB_PHY0		8
+#define RTD1295_RSTN_USB_PHY1		9
+#define RTD1295_RSTN_SATA_PHY_POW_0	10
+#define RTD1295_RSTN_SATA_FUNC_EXIST_0	11
+#define RTD1295_RSTN_HDMI		12
+#define RTD1295_RSTN_VE1		13
+#define RTD1295_RSTN_VE2		14
+#define RTD1295_RSTN_VE3		15
+#define RTD1295_RSTN_ETN		16
+#define RTD1295_RSTN_AIO		17
+#define RTD1295_RSTN_GPU		18
+#define RTD1295_RSTN_TVE		19
+#define RTD1295_RSTN_VO			20
+#define RTD1295_RSTN_LVDS		21
+#define RTD1295_RSTN_SE			22
+#define RTD1295_RSTN_DCU		23
+#define RTD1295_RSTN_DC_PHY		24
+#define RTD1295_RSTN_CP			25
+#define RTD1295_RSTN_MD			26
+#define RTD1295_RSTN_TP			27
+#define RTD1295_RSTN_AE			28
+#define RTD1295_RSTN_NF			29
+#define RTD1295_RSTN_MIPI		30
+#define RTD1295_RSTN_RSA		31
+
+/* soft reset 2 */
+#define RTD1295_RSTN_ACPU		0
+#define RTD1295_RSTN_JPEG		1
+#define RTD1295_RSTN_USB_PHY3		2
+#define RTD1295_RSTN_USB_PHY2		3
+#define RTD1295_RSTN_USB3_PHY1_POW	4
+#define RTD1295_RSTN_USB3_P1_MDIO	5
+#define RTD1295_RSTN_PCIE0_STITCH	6
+#define RTD1295_RSTN_PCIE0_PHY		7
+#define RTD1295_RSTN_PCIE0		8
+#define RTD1295_RSTN_PCR_CNT		9
+#define RTD1295_RSTN_CR			10
+#define RTD1295_RSTN_EMMC		11
+#define RTD1295_RSTN_SDIO		12
+#define RTD1295_RSTN_PCIE0_CORE		13
+#define RTD1295_RSTN_PCIE0_POWER	14
+#define RTD1295_RSTN_PCIE0_NONSTICH	15
+#define RTD1295_RSTN_PCIE1_PHY		16
+#define RTD1295_RSTN_PCIE1		17
+#define RTD1295_RSTN_I2C_5		18
+#define RTD1295_RSTN_PCIE1_STITCH	19
+#define RTD1295_RSTN_PCIE1_CORE		20
+#define RTD1295_RSTN_PCIE1_POWER	21
+#define RTD1295_RSTN_PCIE1_NONSTICH	22
+#define RTD1295_RSTN_I2C_4		23
+#define RTD1295_RSTN_I2C_3		24
+#define RTD1295_RSTN_I2C_2		25
+#define RTD1295_RSTN_I2C_1		26
+#define RTD1295_RSTN_UR2		27
+#define RTD1295_RSTN_UR1		28
+#define RTD1295_RSTN_MISC_SC		29
+#define RTD1295_RSTN_CBUS_TX		30
+#define RTD1295_RSTN_SDS_PHY		31
+
+/* soft reset 4 */
+#define RTD1295_RSTN_DCPHY_CRT		0
+#define RTD1295_RSTN_DCPHY_ALERT_RX	1
+#define RTD1295_RSTN_DCPHY_PTR		2
+#define RTD1295_RSTN_DCPHY_LDO		3
+#define RTD1295_RSTN_DCPHY_SSC_DIG	4
+#define RTD1295_RSTN_HDMIRX		5
+#define RTD1295_RSTN_CBUSRX		6
+#define RTD1295_RSTN_SATA_PHY_POW_1	7
+#define RTD1295_RSTN_SATA_FUNC_EXIST_1	8
+#define RTD1295_RSTN_SATA_PHY_1		9
+#define RTD1295_RSTN_SATA_1		10
+#define RTD1295_RSTN_FAN		11
+#define RTD1295_RSTN_HDMIRX_WRAP	12
+#define RTD1295_RSTN_PCIE0_PHY_MDIO	13
+#define RTD1295_RSTN_PCIE1_PHY_MDIO	14
+#define RTD1295_RSTN_DISP		15
+
+/* iso reset */
+#define RTD1295_ISO_RSTN_IR		1
+#define RTD1295_ISO_RSTN_CEC0		2
+#define RTD1295_ISO_RSTN_CEC1		3
+#define RTD1295_ISO_RSTN_DP		4
+#define RTD1295_ISO_RSTN_CBUSTX		5
+#define RTD1295_ISO_RSTN_CBUSRX		6
+#define RTD1295_ISO_RSTN_EFUSE		7
+#define RTD1295_ISO_RSTN_UR0		8
+#define RTD1295_ISO_RSTN_GMAC		9
+#define RTD1295_ISO_RSTN_GPHY		10
+#define RTD1295_ISO_RSTN_I2C_0		11
+#define RTD1295_ISO_RSTN_I2C_1		12
+#define RTD1295_ISO_RSTN_CBUS		13
+
+#endif
-- 
2.12.3
