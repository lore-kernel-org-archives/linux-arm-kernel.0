From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:52 +0100
Subject: [PATCH 09/25] imx: add namespace prefixes for symbols in mx31.h
In-Reply-To: <1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old names are still defined using the new names.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx31.h |   94 +++++++++++++++++++++-----------
 1 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index 14ac0dc..a4d6901 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -1,45 +1,75 @@
 /*
  * IRAM
  */
-#define MX31_IRAM_BASE_ADDR		0x1FFC0000	/* internal ram */
+#define MX31_IRAM_BASE_ADDR		0x1ffc0000	/* internal ram */
 #define MX31_IRAM_SIZE			SZ_16K
 
-#define MX31_OTG_BASE_ADDR	(AIPS1_BASE_ADDR + 0x00088000)
-#define ATA_BASE_ADDR		(AIPS1_BASE_ADDR + 0x0008C000)
-#define UART4_BASE_ADDR 	(AIPS1_BASE_ADDR + 0x000B0000)
-#define UART5_BASE_ADDR 	(AIPS1_BASE_ADDR + 0x000B4000)
+#define MX31_OTG_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0x88000)
+#define MX31_ATA_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0x8c000)
+#define MX31_UART4_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0xb0000)
+#define MX31_UART5_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0xb4000)
 
-#define MMC_SDHC1_BASE_ADDR	(SPBA0_BASE_ADDR + 0x00004000)
-#define MMC_SDHC2_BASE_ADDR	(SPBA0_BASE_ADDR + 0x00008000)
-#define SIM1_BASE_ADDR		(SPBA0_BASE_ADDR + 0x00018000)
-#define IIM_BASE_ADDR		(SPBA0_BASE_ADDR + 0x0001C000)
+#define MX31_MMC_SDHC1_BASE_ADDR		(MX3x_SPBA0_BASE_ADDR + 0x04000)
+#define MX31_MMC_SDHC2_BASE_ADDR		(MX3x_SPBA0_BASE_ADDR + 0x08000)
+#define MX31_SIM1_BASE_ADDR			(MX3x_SPBA0_BASE_ADDR + 0x18000)
+#define MX31_IIM_BASE_ADDR			(MX3x_SPBA0_BASE_ADDR + 0x1c000)
 
-#define CSPI3_BASE_ADDR		(AIPS2_BASE_ADDR + 0x00084000)
-#define FIRI_BASE_ADDR		(AIPS2_BASE_ADDR + 0x0008C000)
-#define SCM_BASE_ADDR		(AIPS2_BASE_ADDR + 0x000AE000)
-#define SMN_BASE_ADDR		(AIPS2_BASE_ADDR + 0x000AF000)
-#define MPEG4_ENC_BASE_ADDR	(AIPS2_BASE_ADDR + 0x000C8000)
+#define MX31_CSPI3_BASE_ADDR			(MX3x_AIPS2_BASE_ADDR + 0x84000)
+#define MX31_FIRI_BASE_ADDR			(MX3x_AIPS2_BASE_ADDR + 0x8c000)
+#define MX31_SCM_BASE_ADDR			(MX3x_AIPS2_BASE_ADDR + 0xae000)
+#define MX31_SMN_BASE_ADDR			(MX3x_AIPS2_BASE_ADDR + 0xaf000)
+#define MX31_MPEG4_ENC_BASE_ADDR		(MX3x_AIPS2_BASE_ADDR + 0xc8000)
 
-#define MX31_NFC_BASE_ADDR	(X_MEMC_BASE_ADDR + 0x0000)
+#define MX31_NFC_BASE_ADDR			(MX3x_X_MEMC_BASE_ADDR + 0x0000)
 
-#define MXC_INT_MPEG4_ENCODER	5
-#define MXC_INT_FIRI		7
+#define MX31_INT_MPEG4_ENCODER	5
+#define MX31_INT_FIRI		7
 #define MX31_INT_MMC_SDHC2	8
-#define MXC_INT_MMC_SDHC1	9
+#define MX31_INT_MMC_SDHC1	9
 #define MX31_INT_SSI2		11
 #define MX31_INT_SSI1		12
-#define MXC_INT_MBX		16
-#define MXC_INT_CSPI3		17
-#define MXC_INT_SIM2		20
-#define MXC_INT_SIM1		21
-#define MXC_INT_CCM_DVFS	31
-#define MXC_INT_USB1		35
-#define MXC_INT_USB2		36
-#define MXC_INT_USB3		37
-#define MXC_INT_USB4		38
-#define MXC_INT_MSHC2		40
-#define MXC_INT_UART4		46
-#define MXC_INT_UART5		47
-#define MXC_INT_CCM		53
-#define MXC_INT_PCMCIA		54
+#define MX31_INT_MBX		16
+#define MX31_INT_CSPI3		17
+#define MX31_INT_SIM2		20
+#define MX31_INT_SIM1		21
+#define MX31_INT_CCM_DVFS	31
+#define MX31_INT_USB1		35
+#define MX31_INT_USB2		36
+#define MX31_INT_USB3		37
+#define MX31_INT_USB4		38
+#define MX31_INT_MSHC2		40
+#define MX31_INT_UART4		46
+#define MX31_INT_UART5		47
+#define MX31_INT_CCM		53
+#define MX31_INT_PCMCIA		54
 
+/* these should go away */
+#define ATA_BASE_ADDR MX31_ATA_BASE_ADDR
+#define UART4_BASE_ADDR MX31_UART4_BASE_ADDR
+#define UART5_BASE_ADDR MX31_UART5_BASE_ADDR
+#define MMC_SDHC1_BASE_ADDR MX31_MMC_SDHC1_BASE_ADDR
+#define MMC_SDHC2_BASE_ADDR MX31_MMC_SDHC2_BASE_ADDR
+#define SIM1_BASE_ADDR MX31_SIM1_BASE_ADDR
+#define IIM_BASE_ADDR MX31_IIM_BASE_ADDR
+#define CSPI3_BASE_ADDR MX31_CSPI3_BASE_ADDR
+#define FIRI_BASE_ADDR MX31_FIRI_BASE_ADDR
+#define SCM_BASE_ADDR MX31_SCM_BASE_ADDR
+#define SMN_BASE_ADDR MX31_SMN_BASE_ADDR
+#define MPEG4_ENC_BASE_ADDR MX31_MPEG4_ENC_BASE_ADDR
+#define MXC_INT_MPEG4_ENCODER MX31_INT_MPEG4_ENCODER
+#define MXC_INT_FIRI MX31_INT_FIRI
+#define MXC_INT_MMC_SDHC1 MX31_INT_MMC_SDHC1
+#define MXC_INT_MBX MX31_INT_MBX
+#define MXC_INT_CSPI3 MX31_INT_CSPI3
+#define MXC_INT_SIM2 MX31_INT_SIM2
+#define MXC_INT_SIM1 MX31_INT_SIM1
+#define MXC_INT_CCM_DVFS MX31_INT_CCM_DVFS
+#define MXC_INT_USB1 MX31_INT_USB1
+#define MXC_INT_USB2 MX31_INT_USB2
+#define MXC_INT_USB3 MX31_INT_USB3
+#define MXC_INT_USB4 MX31_INT_USB4
+#define MXC_INT_MSHC2 MX31_INT_MSHC2
+#define MXC_INT_UART4 MX31_INT_UART4
+#define MXC_INT_UART5 MX31_INT_UART5
+#define MXC_INT_CCM MX31_INT_CCM
+#define MXC_INT_PCMCIA MX31_INT_PCMCIA
-- 
1.6.5.2
