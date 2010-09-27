From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:04 +0200
Subject: [PATCH 28/40] ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2
	on the imx51_3ds board
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-28-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Wang <jason77.wang@gmail.com>

On the imx51_3ds board, eCSPI2 is connected to a SPI NOR flash,
now add iomux definitions for those used pins.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 0d77be3..d0ef881 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -45,6 +45,8 @@ typedef enum iomux_config {
 				PAD_CTL_PKE | PAD_CTL_HYS)
 #define MX51_GPIO_PAD_CTRL		(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
 				PAD_CTL_SRE_FAST)
+#define MX51_ECSPI_PAD_CTRL	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_DSE_HIGH | \
+				PAD_CTL_SRE_FAST)
 
 #define MX51_PAD_CTRL_1	(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | \
 					PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_HYS)
@@ -139,8 +141,10 @@ typedef enum iomux_config {
 #define MX51_PAD_NANDF_RB0__GPIO_3_8            IOMUX_PAD(0x4F8, 0x11C, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_NANDF_RB1__GPIO_3_9            IOMUX_PAD(0x4FC, 0x120, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_NANDF_RB2__GPIO_3_10           IOMUX_PAD(0x500, 0x124, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_NANDF_RB2__ECSPI2_SCLK         IOMUX_PAD(0x500, 0x124, 2, 0x0,   0, MX51_ECSPI_PAD_CTRL)
 #define MX51_PAD_NANDF_RB2__FEC_COL		IOMUX_PAD(0x500, 0x124, 1, 0x0,   0, MX51_PAD_CTRL_2)
 #define MX51_PAD_NANDF_RB3__GPIO_3_11           IOMUX_PAD(0x504, 0x128, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_NANDF_RB3__ECSPI2_MISO         IOMUX_PAD(0x504, 0x128, 2, 0x0,   0, MX51_ECSPI_PAD_CTRL)
 #define MX51_PAD_NANDF_RB3__FEC_RXCLK		IOMUX_PAD(0x504, 0x128, 1, 0x0,   0, MX51_PAD_CTRL_2)
 #define MX51_PAD_NANDF_RB6__FEC_RDAT0		IOMUX_PAD(0x5DC, 0x134, 1, 0x0,   0, MX51_PAD_CTRL_4)
 #define MX51_PAD_NANDF_RB7__FEC_TDAT0		IOMUX_PAD(0x5E0, 0x138, 1, 0x0,   0, MX51_PAD_CTRL_5)
@@ -162,6 +166,7 @@ typedef enum iomux_config {
 #define MX51_PAD_NANDF_RDY_INT__GPIO_3_24       IOMUX_PAD(0x538, 0x150, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK	IOMUX_PAD(0x538, 0x150, 1, 0x0,   0, MX51_PAD_CTRL_4)
 #define MX51_PAD_NANDF_D15__GPIO_3_25           IOMUX_PAD(0x53C, 0x154, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_NANDF_D15__ECSPI2_MOSI         IOMUX_PAD(0x53C, 0x154, 2, 0x0,   0, MX51_ECSPI_PAD_CTRL)
 #define MX51_PAD_NANDF_D14__GPIO_3_26           IOMUX_PAD(0x540, 0x158, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_NANDF_D13__GPIO_3_27           IOMUX_PAD(0x544, 0x15C, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_NANDF_D12__GPIO_3_28           IOMUX_PAD(0x548, 0x160, 3, 0x0,   0, NO_PAD_CTRL)
-- 
1.7.2.3
