From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 14:23:12 +0200
Subject: [PATCH 3/4] iomux-mx51: fix SD1 and SD2's iomux configuration
In-Reply-To: <20101012093225.GF29673@pengutronix.d>
References: <20101012093225.GF29673@pengutronix.d>
Message-ID: <1286886193-28960-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on original patch from: Richard Zhu <r65037@freescale.com>
Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |   39 ++++++++++++++++++--------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 5160f10..93141d1 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -47,6 +47,9 @@ typedef enum iomux_config {
 				PAD_CTL_SRE_FAST)
 #define MX51_ECSPI_PAD_CTRL	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_DSE_HIGH | \
 				PAD_CTL_SRE_FAST)
+#define MX51_SDHCI_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP | \
+				PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_SRE_FAST | \
+				PAD_CTL_DVS)
 
 #define MX51_PAD_CTRL_1	(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | \
 					PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_HYS)
@@ -333,26 +336,38 @@ typedef enum iomux_config {
 #define MX51_PAD_DISP2_DAT13__DISP2_DAT13       IOMUX_PAD(0x790, 0x388, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x38C, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x390, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x394, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_CMD__SD1_CMD		IOMUX_PAD(0x79C, 0x394, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_SD1_CMD__AUD5_RXFS             IOMUX_PAD(0x79C, 0x394, 1, 0x8e0, 1, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x398, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_CLK__SD1_CLK		IOMUX_PAD(0x7A0, 0x398, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
 #define MX51_PAD_SD1_CLK__AUD5_RXC              IOMUX_PAD(0x7A0, 0x398, 1, 0x8dc, 1, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x39C, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA0__SD1_DATA0		IOMUX_PAD(0x7A4, 0x39C, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_SD1_DATA0__AUD5_TXD            IOMUX_PAD(0x7A4, 0x39C, 1, 0x8d8, 2, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA1__SD1_DATA1           IOMUX_PAD(0x7A8, 0x3A0, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA1__SD1_DATA1		IOMUX_PAD(0x7A8, 0x3A0, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_SD1_DATA1__AUD5_RXD            IOMUX_PAD(0x7A8, 0x3A0, 1, 0x8d4, 2, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA2__SD1_DATA2           IOMUX_PAD(0x7AC, 0x3A4, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA2__SD1_DATA2		IOMUX_PAD(0x7AC, 0x3A4, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_SD1_DATA2__AUD5_TXC            IOMUX_PAD(0x7AC, 0x3A4, 1, 0x8e4, 2, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA3__SD1_DATA3           IOMUX_PAD(0x7B0, 0x3A8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA3__SD1_DATA3		IOMUX_PAD(0x7B0, 0x3A8, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_SD1_DATA3__AUD5_TXFS           IOMUX_PAD(0x7B0, 0x3A8, 1, 0x8e8, 2, NO_PAD_CTRL)
+#define MX51_PAD_SD2_CMD__SD2_CMD		IOMUX_PAD(0x7BC, 0x3B4, IOMUX_CONFIG_SION, 0x0, 1, \
+							MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_CLK__SD2_CLK		IOMUX_PAD(0x7C0, 0x3B8, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
+#define MX51_PAD_SD2_DATA0__SD2_DATA0		IOMUX_PAD(0x7C4, 0x3BC, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA1__SD2_DATA1		IOMUX_PAD(0x7C8, 0x3C0, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA2__SD2_DATA2		IOMUX_PAD(0x7CC, 0x3C4, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA3__SD2_DATA3		IOMUX_PAD(0x7D0, 0x3C8, IOMUX_CONFIG_SION, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CMD__SD2_CMD               IOMUX_PAD(0x7BC, 0x3B4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CLK__SD2_CLK               IOMUX_PAD(0x7C0, 0x3B8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA0__SD2_DATA0           IOMUX_PAD(0x7C4, 0x3BC, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA1__SD2_DATA1           IOMUX_PAD(0x7C8, 0x3C0, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA2__SD2_DATA2           IOMUX_PAD(0x7CC, 0x3C4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA3__SD2_DATA3           IOMUX_PAD(0x7D0, 0x3C8, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
 							0x9b8,   3, MX51_I2C_PAD_CTRL)
-- 
1.7.0.4
