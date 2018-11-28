From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Thu, 29 Nov 2018 01:33:22 +0300
Subject: [PATCH v5 12/17] dt-bindings: clock: Add Allwinner suniv F1C100s CCU
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
Message-ID: <47d0f466155e3d678d3383655856c1e15e975870.1543443475.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatiple string for Allwinner suniv F1C100s CCU.
Add clock and reset definitions.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 70 ++++++++++++++++++++++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 38 ++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 47d2e90..e3bd88a 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -22,6 +22,7 @@ Required properties :
 		- "allwinner,sun50i-h5-ccu"
 		- "allwinner,sun50i-h6-ccu"
 		- "allwinner,sun50i-h6-r-ccu"
+		- "allwinner,suniv-f1c100s-ccu"
 		- "nextthing,gr8-ccu"
 
 - reg: Must contain the registers base address and length
diff --git a/include/dt-bindings/clock/suniv-ccu-f1c100s.h b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..f5ac155
--- /dev/null
+++ b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ *
+ * Copyright (c) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+
+#define CLK_CPU			11
+
+#define CLK_BUS_DMA		14
+#define CLK_BUS_MMC0		15
+#define CLK_BUS_MMC1		16
+#define CLK_BUS_DRAM		17
+#define CLK_BUS_SPI0		18
+#define CLK_BUS_SPI1		19
+#define CLK_BUS_OTG		20
+#define CLK_BUS_VE		21
+#define CLK_BUS_LCD		22
+#define CLK_BUS_DEINTERLACE	23
+#define CLK_BUS_CSI		24
+#define CLK_BUS_TVD		25
+#define CLK_BUS_TVE		26
+#define CLK_BUS_DE_BE		27
+#define CLK_BUS_DE_FE		28
+#define CLK_BUS_CODEC		29
+#define CLK_BUS_SPDIF		30
+#define CLK_BUS_IR		31
+#define CLK_BUS_RSB		32
+#define CLK_BUS_I2S0		33
+#define CLK_BUS_I2C0		34
+#define CLK_BUS_I2C1		35
+#define CLK_BUS_I2C2		36
+#define CLK_BUS_PIO		37
+#define CLK_BUS_UART0		38
+#define CLK_BUS_UART1		39
+#define CLK_BUS_UART2		40
+
+#define CLK_MMC0		41
+#define CLK_MMC0_SAMPLE		42
+#define CLK_MMC0_OUTPUT		43
+#define CLK_MMC1		44
+#define CLK_MMC1_SAMPLE		45
+#define CLK_MMC1_OUTPUT		46
+#define CLK_I2S			47
+#define CLK_SPDIF		48
+
+#define CLK_USB_PHY0		49
+
+#define CLK_DRAM_VE		50
+#define CLK_DRAM_CSI		51
+#define CLK_DRAM_DEINTERLACE	52
+#define CLK_DRAM_TVD		53
+#define CLK_DRAM_DE_FE		54
+#define CLK_DRAM_DE_BE		55
+
+#define CLK_DE_BE		56
+#define CLK_DE_FE		57
+#define CLK_TCON		58
+#define CLK_DEINTERLACE		59
+#define CLK_TVE2_CLK		60
+#define CLK_TVE1_CLK		61
+#define CLK_TVD			62
+#define CLK_CSI			63
+#define CLK_VE			64
+#define CLK_CODEC		65
+#define CLK_AVS			66
+
+#endif
diff --git a/include/dt-bindings/reset/suniv-ccu-f1c100s.h b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..6a4b438
--- /dev/null
+++ b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ *
+ * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ */
+
+#ifndef _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+
+#define RST_USB_PHY0		0
+#define RST_BUS_DMA		1
+#define RST_BUS_MMC0		2
+#define RST_BUS_MMC1		3
+#define RST_BUS_DRAM		4
+#define RST_BUS_SPI0		5
+#define RST_BUS_SPI1		6
+#define RST_BUS_OTG		7
+#define RST_BUS_VE		8
+#define RST_BUS_LCD		9
+#define RST_BUS_DEINTERLACE	10
+#define RST_BUS_CSI		11
+#define RST_BUS_TVD		12
+#define RST_BUS_TVE		13
+#define RST_BUS_DE_BE		14
+#define RST_BUS_DE_FE		15
+#define RST_BUS_CODEC		16
+#define RST_BUS_SPDIF		17
+#define RST_BUS_IR		18
+#define RST_BUS_RSB		19
+#define RST_BUS_I2S0		20
+#define RST_BUS_I2C0		21
+#define RST_BUS_I2C1		22
+#define RST_BUS_I2C2		23
+#define RST_BUS_UART0		24
+#define RST_BUS_UART1		25
+#define RST_BUS_UART2		26
+
+#endif /* _DT_BINDINGS_RST_SUNIV_F1C100S_H_ */
-- 
2.7.4
