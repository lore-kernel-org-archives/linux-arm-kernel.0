From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Thu, 13 Jan 2011 11:36:03 +0800
Subject: [PATCH 2/3] ARM: i.MX53 EVK: add ecspi IOMUX setting
Message-ID: <1294889764-16267-2-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

add ecspi IOMUX setting, also fix a bug of chip select pin order

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 8017d68..2cb4415 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -33,8 +33,8 @@
 #include <mach/iomux-mx53.h>
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
-#define EVK_ECSPI1_CS0		IMX_GPIO_NR(3, 19)
-#define EVK_ECSPI1_CS1		IMX_GPIO_NR(2, 30)
+#define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
+#define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
@@ -54,6 +54,14 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 	MX53_PAD_ATA_CS_1__UART3_RXD,
 	MX53_PAD_ATA_DA_1__UART3_CTS,
 	MX53_PAD_ATA_DA_2__UART3_RTS,
+
+	MX53_PAD_EIM_D16__CSPI1_SCLK,
+	MX53_PAD_EIM_D17__CSPI1_MISO,
+	MX53_PAD_EIM_D18__CSPI1_MOSI,
+
+	/* ecspi chip select lines */
+	MX53_PAD_EIM_EB2__GPIO_2_30,
+	MX53_PAD_EIM_D19__GPIO_3_19,
 };
 
 static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
-- 
1.7.1
