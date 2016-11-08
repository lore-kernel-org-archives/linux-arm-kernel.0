From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  8 Nov 2016 18:23:08 +0100
Subject: [PATCH 4/10] clk: sunxi-ng: Add clocks and resets indices for sun5i
In-Reply-To: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
References: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8fbb8e05d73282fb5e7d33f8faffbeaccf63aeae.1478625788.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoCs part of the sun5i family share the DTs, so we need consistant
indices in order to still share the DTs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/dt-bindings/clock/sun5i-ccu.h | 126 +++++++++++++++++++++++++++-
 include/dt-bindings/reset/sun5i-ccu.h |  32 +++++++-
 2 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun5i-ccu.h
 create mode 100644 include/dt-bindings/reset/sun5i-ccu.h

diff --git a/include/dt-bindings/clock/sun5i-ccu.h b/include/dt-bindings/clock/sun5i-ccu.h
new file mode 100644
index 000000000000..32735b2cf29c
--- /dev/null
+++ b/include/dt-bindings/clock/sun5i-ccu.h
@@ -0,0 +1,126 @@
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
+#ifndef _CCU_SUN5I_H_
+#define _CCU_SUN5I_H_
+
+#define CLK_HOSC		1
+#define CLK_OSC3M		2
+#define CLK_PLL_CORE		3
+#define CLK_PLL_AUDIO_BASE	4
+#define CLK_PLL_AUDIO		5
+#define CLK_PLL_AUDIO_2X	6
+#define CLK_PLL_AUDIO_4X	7
+#define CLK_PLL_AUDIO_8X	8
+#define CLK_PLL_VIDEO0		9
+#define CLK_PLL_VIDEO0_2X	10
+#define CLK_PLL_VE		11
+#define CLK_PLL_DDR_BASE	12
+#define CLK_PLL_DDR		13
+#define CLK_PLL_DDR_OTHER	14
+#define CLK_PLL_PERIPH		15
+#define CLK_PLL_VIDEO1		16
+#define CLK_PLL_VIDEO1_2X	17
+#define CLK_OSC24M		18
+#define CLK_CPU			19
+#define CLK_AXI			20
+#define CLK_AHB			21
+#define CLK_APB0		22
+#define CLK_APB1		23
+#define CLK_DRAM_AXI		24
+#define CLK_AHB_OTG		25
+#define CLK_AHB_EHCI		26
+#define CLK_AHB_OHCI		27
+#define CLK_AHB_SS		28
+#define CLK_AHB_DMA		29
+#define CLK_AHB_BIST		30
+#define CLK_AHB_MMC0		31
+#define CLK_AHB_MMC1		32
+#define CLK_AHB_MMC2		33
+#define CLK_AHB_NAND		34
+#define CLK_AHB_SDRAM		35
+#define CLK_AHB_EMAC		36
+#define CLK_AHB_TS		37
+#define CLK_AHB_SPI0		38
+#define CLK_AHB_SPI1		39
+#define CLK_AHB_SPI2		40
+#define CLK_AHB_GPS		41
+#define CLK_AHB_HSTIMER		42
+#define CLK_AHB_VE		43
+#define CLK_AHB_TVE		44
+#define CLK_AHB_LCD		45
+#define CLK_AHB_CSI		46
+#define CLK_AHB_HDMI		47
+#define CLK_AHB_DE_BE		48
+#define CLK_AHB_DE_FE		49
+#define CLK_AHB_IEP		50
+#define CLK_AHB_GPU		51
+#define CLK_APB0_CODEC		52
+#define CLK_APB0_SPDIF		53
+#define CLK_APB0_I2S		54
+#define CLK_APB0_PIO		55
+#define CLK_APB0_IR		56
+#define CLK_APB0_KEYPAD		57
+#define CLK_APB1_I2C0		58
+#define CLK_APB1_I2C1		59
+#define CLK_APB1_I2C2		60
+#define CLK_APB1_UART0		61
+#define CLK_APB1_UART1		62
+#define CLK_APB1_UART2		63
+#define CLK_APB1_UART3		64
+#define CLK_NAND		65
+#define CLK_MMC0		66
+#define CLK_MMC1		67
+#define CLK_MMC2		68
+#define CLK_TS			69
+#define CLK_SS			70
+#define CLK_CE			71
+#define CLK_SPI0		72
+#define CLK_SPI1		73
+#define CLK_SPI2		74
+#define CLK_IR			75
+#define CLK_I2S			76
+#define CLK_SPDIF		77
+#define CLK_KEYPAD		78
+#define CLK_USB_OHCI		79
+#define CLK_USB_PHY0		80
+#define CLK_USB_PHY1		81
+#define CLK_GPS			82
+#define CLK_DRAM_VE		83
+#define CLK_DRAM_CSI		84
+#define CLK_DRAM_TS		85
+#define CLK_DRAM_TVE		86
+#define CLK_DRAM_DE_FE		87
+#define CLK_DRAM_DE_BE		88
+#define CLK_DRAM_ACE		89
+#define CLK_DRAM_IEP		90
+#define CLK_DE_BE		91
+#define CLK_DE_FE		92
+#define CLK_TCON_CH0		93
+#define CLK_TCON_CH1_SCLK	94
+#define CLK_TCON_CH1		95
+#define CLK_CSI			96
+#define CLK_VE			97
+#define CLK_CODEC		98
+#define CLK_AVS			99
+#define CLK_HDMI		100
+#define CLK_GPU			101
+#define CLK_MBUS		102
+#define CLK_IEP			103
+
+#define CLK_NUMBER		(CLK_IEP + 1)
+
+#endif /* _CCU_SUN5I_H_ */
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
