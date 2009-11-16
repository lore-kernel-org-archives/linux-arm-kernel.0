From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:49 +0100
Subject: [PATCH 06/25] imx: add namespace prefixes for symbols in mx21.h
In-Reply-To: <1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old names are still defined using the new names.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx21.h |   95 ++++++++++++++++++++++-----------
 1 files changed, 64 insertions(+), 31 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index 2b1fccb..986f08b 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -26,45 +26,78 @@
 #define __ASM_ARCH_MXC_MX21_H__
 
 /* Memory regions and CS */
-#define SDRAM_BASE_ADDR         0xC0000000
-#define CSD1_BASE_ADDR          0xC4000000
+#define MX21_SDRAM_BASE_ADDR		0xc0000000
+#define MX21_CSD1_BASE_ADDR		0xc4000000
 
-#define CS0_BASE_ADDR           0xC8000000
-#define CS1_BASE_ADDR           0xCC000000
-#define CS2_BASE_ADDR           0xD0000000
-#define CS3_BASE_ADDR           0xD1000000
-#define CS4_BASE_ADDR           0xD2000000
-#define PCMCIA_MEM_BASE_ADDR    0xD4000000
-#define CS5_BASE_ADDR           0xDD000000
+#define MX21_CS0_BASE_ADDR		0xc8000000
+#define MX21_CS1_BASE_ADDR		0xcc000000
+#define MX21_CS2_BASE_ADDR		0xd0000000
+#define MX21_CS3_BASE_ADDR		0xd1000000
+#define MX21_CS4_BASE_ADDR		0xd2000000
+#define MX21_PCMCIA_MEM_BASE_ADDR	0xd4000000
+#define MX21_CS5_BASE_ADDR		0xdd000000
 
 /* NAND, SDRAM, WEIM etc controllers */
-#define X_MEMC_BASE_ADDR        0xDF000000
-#define X_MEMC_BASE_ADDR_VIRT   0xF4200000
-#define X_MEMC_SIZE             SZ_256K
+#define MX21_X_MEMC_BASE_ADDR		0xdf000000
+#define MX21_X_MEMC_BASE_ADDR_VIRT	0xf4200000
+#define MX21_X_MEMC_SIZE		SZ_256K
 
-#define SDRAMC_BASE_ADDR        (X_MEMC_BASE_ADDR + 0x0000)
-#define EIM_BASE_ADDR           (X_MEMC_BASE_ADDR + 0x1000)
-#define PCMCIA_CTL_BASE_ADDR    (X_MEMC_BASE_ADDR + 0x2000)
-#define NFC_BASE_ADDR           (X_MEMC_BASE_ADDR + 0x3000)
+#define MX21_SDRAMC_BASE_ADDR		(MX21_X_MEMC_BASE_ADDR + 0x0000)
+#define MX21_EIM_BASE_ADDR		(MX21_X_MEMC_BASE_ADDR + 0x1000)
+#define MX21_PCMCIA_CTL_BASE_ADDR	(MX21_X_MEMC_BASE_ADDR + 0x2000)
+#define MX21_NFC_BASE_ADDR		(MX21_X_MEMC_BASE_ADDR + 0x3000)
 
-#define IRAM_BASE_ADDR          0xFFFFE800	/* internal ram */
+#define MX21_IRAM_BASE_ADDR		0xffffe800	/* internal ram */
 
 /* fixed interrupt numbers */
-#define MXC_INT_FIRI            9
-#define MXC_INT_BMI             30
-#define MXC_INT_EMMAENC         49
-#define MXC_INT_EMMADEC         50
-#define MXC_INT_USBWKUP         53
-#define MXC_INT_USBDMA          54
-#define MXC_INT_USBHOST         55
-#define MXC_INT_USBFUNC         56
-#define MXC_INT_USBMNP          57
-#define MXC_INT_USBCTRL         58
-#define MXC_INT_USBCTRL         58
+#define MX21_INT_FIRI		9
+#define MX21_INT_BMI		30
+#define MX21_INT_EMMAENC	49
+#define MX21_INT_EMMADEC	50
+#define MX21_INT_USBWKUP	53
+#define MX21_INT_USBDMA		54
+#define MX21_INT_USBHOST	55
+#define MX21_INT_USBFUNC	56
+#define MX21_INT_USBMNP		57
+#define MX21_INT_USBCTRL	58
+#define MX21_INT_USBCTRL	58
 
 /* fixed DMA request numbers */
-#define DMA_REQ_FIRI_RX         4
-#define DMA_REQ_BMI_TX          28
-#define DMA_REQ_BMI_RX          29
+#define MX21_DMA_REQ_FIRI_RX	4
+#define MX21_DMA_REQ_BMI_TX	28
+#define MX21_DMA_REQ_BMI_RX	29
+
+/* these should go away */
+#define SDRAM_BASE_ADDR MX21_SDRAM_BASE_ADDR
+#define CSD1_BASE_ADDR MX21_CSD1_BASE_ADDR
+#define CS0_BASE_ADDR MX21_CS0_BASE_ADDR
+#define CS1_BASE_ADDR MX21_CS1_BASE_ADDR
+#define CS2_BASE_ADDR MX21_CS2_BASE_ADDR
+#define CS3_BASE_ADDR MX21_CS3_BASE_ADDR
+#define CS4_BASE_ADDR MX21_CS4_BASE_ADDR
+#define PCMCIA_MEM_BASE_ADDR MX21_PCMCIA_MEM_BASE_ADDR
+#define CS5_BASE_ADDR MX21_CS5_BASE_ADDR
+#define X_MEMC_BASE_ADDR MX21_X_MEMC_BASE_ADDR
+#define X_MEMC_BASE_ADDR_VIRT MX21_X_MEMC_BASE_ADDR_VIRT
+#define X_MEMC_SIZE MX21_X_MEMC_SIZE
+#define SDRAMC_BASE_ADDR MX21_SDRAMC_BASE_ADDR
+#define EIM_BASE_ADDR MX21_EIM_BASE_ADDR
+#define PCMCIA_CTL_BASE_ADDR MX21_PCMCIA_CTL_BASE_ADDR
+#define NFC_BASE_ADDR MX21_NFC_BASE_ADDR
+#define IRAM_BASE_ADDR MX21_IRAM_BASE_ADDR
+#define MXC_INT_FIRI MX21_INT_FIRI
+#define MXC_INT_BMI MX21_INT_BMI
+#define MXC_INT_EMMAENC MX21_INT_EMMAENC
+#define MXC_INT_EMMADEC MX21_INT_EMMADEC
+#define MXC_INT_USBWKUP MX21_INT_USBWKUP
+#define MXC_INT_USBDMA MX21_INT_USBDMA
+#define MXC_INT_USBHOST MX21_INT_USBHOST
+#define MXC_INT_USBFUNC MX21_INT_USBFUNC
+#define MXC_INT_USBMNP MX21_INT_USBMNP
+#define MXC_INT_USBCTRL MX21_INT_USBCTRL
+#define MXC_INT_USBCTRL MX21_INT_USBCTRL
+#define DMA_REQ_FIRI_RX MX21_DMA_REQ_FIRI_RX
+#define DMA_REQ_BMI_TX MX21_DMA_REQ_BMI_TX
+#define DMA_REQ_BMI_RX MX21_DMA_REQ_BMI_RX
 
 #endif /* __ASM_ARCH_MXC_MX21_H__ */
-- 
1.6.5.2
