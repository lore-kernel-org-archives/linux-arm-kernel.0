From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jan 2017 08:57:26 +0100
Subject: [PATCH v2 4/7] clk: sunxi-ng: Add clocks and resets indices for sun5i
In-Reply-To: <cover.8762813dc78858261716126c700983d4aee00458.1484035021.git-series.maxime.ripard@free-electrons.com>
References: <cover.8762813dc78858261716126c700983d4aee00458.1484035021.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b58205e51f84da9a59ca617906b4524d7e976f58.1484035021.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoCs part of the sun5i family share the DTs, so we need consistant
indices in order to still share the DTs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/dt-bindings/clock/sun5i-ccu.h | 103 +++++++++++++++++++++++++++-
 include/dt-bindings/reset/sun5i-ccu.h |  32 ++++++++-
 2 files changed, 135 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun5i-ccu.h
 create mode 100644 include/dt-bindings/reset/sun5i-ccu.h

diff --git a/include/dt-bindings/clock/sun5i-ccu.h b/include/dt-bindings/clock/sun5i-ccu.h
new file mode 100644
index 000000000000..792ebd9c30e6
--- /dev/null
+++ b/include/dt-bindings/clock/sun5i-ccu.h
@@ -0,0 +1,103 @@
+/*
+ * Copyright 2016 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN5I_H_
+#define _DT_BINDINGS_CLK_SUN5I_H_
+
+#define CLK_HOSC		1
+
+#define CLK_CPU			18
+
+#define CLK_AHB_OTG		24
+#define CLK_AHB_EHCI		25
+#define CLK_AHB_OHCI		26
+#define CLK_AHB_SS		27
+#define CLK_AHB_DMA		28
+#define CLK_AHB_BIST		29
+#define CLK_AHB_MMC0		30
+#define CLK_AHB_MMC1		31
+#define CLK_AHB_MMC2		32
+#define CLK_AHB_NAND		33
+#define CLK_AHB_SDRAM		34
+#define CLK_AHB_EMAC		35
+#define CLK_AHB_TS		36
+#define CLK_AHB_SPI0		37
+#define CLK_AHB_SPI1		38
+#define CLK_AHB_SPI2		39
+#define CLK_AHB_GPS		40
+#define CLK_AHB_HSTIMER		41
+#define CLK_AHB_VE		42
+#define CLK_AHB_TVE		43
+#define CLK_AHB_LCD		44
+#define CLK_AHB_CSI		45
+#define CLK_AHB_HDMI		46
+#define CLK_AHB_DE_BE		47
+#define CLK_AHB_DE_FE		48
+#define CLK_AHB_IEP		49
+#define CLK_AHB_GPU		50
+#define CLK_APB0_CODEC		51
+#define CLK_APB0_SPDIF		52
+#define CLK_APB0_I2S		53
+#define CLK_APB0_PIO		54
+#define CLK_APB0_IR		55
+#define CLK_APB0_KEYPAD		56
+#define CLK_APB1_I2C0		57
+#define CLK_APB1_I2C1		58
+#define CLK_APB1_I2C2		59
+#define CLK_APB1_UART0		60
+#define CLK_APB1_UART1		61
+#define CLK_APB1_UART2		62
+#define CLK_APB1_UART3		63
+#define CLK_NAND		64
+#define CLK_MMC0		65
+#define CLK_MMC1		66
+#define CLK_MMC2		67
+#define CLK_TS			68
+#define CLK_SS			69
+#define CLK_SPI0		70
+#define CLK_SPI1		71
+#define CLK_SPI2		72
+#define CLK_IR			73
+#define CLK_I2S			74
+#define CLK_SPDIF		75
+#define CLK_KEYPAD		76
+#define CLK_USB_OHCI		77
+#define CLK_USB_PHY0		78
+#define CLK_USB_PHY1		79
+#define CLK_GPS			80
+#define CLK_DRAM_VE		81
+#define CLK_DRAM_CSI		82
+#define CLK_DRAM_TS		83
+#define CLK_DRAM_TVE		84
+#define CLK_DRAM_DE_FE		85
+#define CLK_DRAM_DE_BE		86
+#define CLK_DRAM_ACE		87
+#define CLK_DRAM_IEP		88
+#define CLK_DE_BE		89
+#define CLK_DE_FE		90
+#define CLK_TCON_CH0		91
+
+#define CLK_TCON_CH1		93
+#define CLK_CSI			94
+#define CLK_VE			95
+#define CLK_CODEC		96
+#define CLK_AVS			97
+#define CLK_HDMI		98
+#define CLK_GPU			99
+
+#define CLK_IEP			101
+
+#endif /* _DT_BINDINGS_CLK_SUN5I_H_ */
diff --git a/include/dt-bindings/reset/sun5i-ccu.h b/include/dt-bindings/reset/sun5i-ccu.h
new file mode 100644
index 000000000000..c2b9726b5026
--- /dev/null
+++ b/include/dt-bindings/reset/sun5i-ccu.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2016 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _RST_SUN5I_H_
+#define _RST_SUN5I_H_
+
+#define RST_USB_PHY0	0
+#define RST_USB_PHY1	1
+#define RST_GPS		2
+#define RST_DE_BE	3
+#define RST_DE_FE	4
+#define RST_TVE		5
+#define RST_LCD		6
+#define RST_CSI		7
+#define RST_VE		8
+#define RST_GPU		9
+#define RST_IEP		10
+
+#endif /* _RST_SUN5I_H_ */
-- 
git-series 0.8.11
