From: jason77.wang@gmail.com (Jason Wang)
Date: Sat, 12 Jun 2010 22:22:38 +0800
Subject: [PATCH 3/4] mx51/iomux: add UART and GPIO pad definitions for
	imx51_3ds board
In-Reply-To: <1276352559-8105-3-git-send-email-jason77.wang@gmail.com>
References: <1276352559-8105-1-git-send-email-jason77.wang@gmail.com>
	<1276352559-8105-2-git-send-email-jason77.wang@gmail.com>
	<1276352559-8105-3-git-send-email-jason77.wang@gmail.com>
Message-ID: <1276352559-8105-4-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add UART2 CTS/RTS and UART3 RXD/TXD pad definitons for imx51_3ds board,
add GPIO_1_6 definiton because this pin is used as a CPLD parent irq
request pin on imx51_3ds board.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 7433369..2fc6559 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -77,7 +77,9 @@ typedef enum iomux_config {
 #define MX51_PAD_EIM_D23__GPIO_2_7              IOMUX_PAD(0x40c, 0x078, 1, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_D24__UART3_CTS             IOMUX_PAD(0x410, 0x07c, 3, 0x0,   0, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_EIM_D25__UART3_RXD             IOMUX_PAD(0x414, 0x080, 3, 0x9f4, 0, MX51_UART3_PAD_CTRL)
+#define MX51_PAD_EIM_D25__UART2_CTS		IOMUX_PAD(0x414, 0x080, 4, 0x0,   0, MX51_UART2_PAD_CTRL)
 #define MX51_PAD_EIM_D26__UART3_TXD             IOMUX_PAD(0x418, 0x084, 3, 0x0,   0, MX51_UART3_PAD_CTRL)
+#define MX51_PAD_EIM_D26__UART2_RTS		IOMUX_PAD(0x418, 0x084, 4, 0x9e8, 3, MX51_UART2_PAD_CTRL)
 #define MX51_PAD_EIM_D27__UART3_RTS             IOMUX_PAD(0x41c, 0x088, 3, 0x9f0, 3, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_EIM_D28__EIM_D28               IOMUX_PAD(0x420, 0x08c, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_EIM_D29__EIM_D29               IOMUX_PAD(0x424, 0x090, 0, 0x0,   0, NO_PAD_CTRL)
@@ -191,7 +193,9 @@ typedef enum iomux_config {
 #define MX51_PAD_UART1_CTS__UART1_CTS           IOMUX_PAD(0x624, 0x234, 0, 0x0,   0, MX51_UART1_PAD_CTRL)
 #define MX51_PAD_UART2_RXD__UART2_RXD           IOMUX_PAD(0x628, 0x238, 0, 0x9ec, 2, MX51_UART2_PAD_CTRL)
 #define MX51_PAD_UART2_TXD__UART2_TXD           IOMUX_PAD(0x62C, 0x23C, 0, 0x0,   0, MX51_UART2_PAD_CTRL)
+#define MX51_PAD_UART3_RXD__UART3_RXD		IOMUX_PAD(0x630, 0x240, 1, 0x9f4, 4, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_UART3_RXD__GPIO_1_22           IOMUX_PAD(0x630, 0x240, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_UART3_TXD__UART3_TXD		IOMUX_PAD(0x634, 0x244, 1, 0x0,   0, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_UART3_TXD__GPIO_1_23           IOMUX_PAD(0x634, 0x244, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_OWIRE_LINE__GPIO_1_24          IOMUX_PAD(0x638, 0x248, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_KEY_ROW0__KEY_ROW0             IOMUX_PAD(0x63C, 0x24C, 0, 0x0,   0, NO_PAD_CTRL)
@@ -295,7 +299,7 @@ typedef enum iomux_config {
 #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_9__GPIO_1_9		IOMUX_PAD(0x818, 0x3EC, 0, 0x0,   0, NO_PAD_CTRL)
-- 
1.5.6.5
