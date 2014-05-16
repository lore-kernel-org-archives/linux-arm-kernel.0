From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 16 May 2014 11:09:29 +0200
Subject: [PATCH v2] ARM: imx: remove unused defines
In-Reply-To: <20140515122553.GF5858@pengutronix.de>
References: <1400140671.20469.7.camel@x220>
 <20140515122553.GF5858@pengutronix.de>
Message-ID: <1400231369.20342.10.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the defines "for modules using static and dynamic DMA channels"
are used. Remove these.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) v1 was called "ARM: imx: remove check for CONFIG_SDMA_IRAM". This
version just removes the entire block of defines, as Sascha suggested.

1) Still untested.

 arch/arm/mach-imx/mx51.h | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/arm/mach-imx/mx51.h b/arch/arm/mach-imx/mx51.h
index af844f76261a..3f6d4a674ffb 100644
--- a/arch/arm/mach-imx/mx51.h
+++ b/arch/arm/mach-imx/mx51.h
@@ -145,39 +145,6 @@
 #define MX51_SPBA_CTRL	0x3c
 
 /*
- * Defines for modules using static and dynamic DMA channels
- */
-#define MX51_MXC_DMA_CHANNEL_IRAM	30
-#define MX51_MXC_DMA_CHANNEL_SPDIF_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_UART1_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_UART1_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_UART2_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_UART2_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_UART3_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_UART3_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_MMC1	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_MMC2	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_SSI1_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_SSI1_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_SSI2_RX	MXC_DMA_DYNAMIC_CHANNEL
-#ifdef CONFIG_SDMA_IRAM
-#define MX51_MXC_DMA_CHANNEL_SSI2_TX	(MX51_MXC_DMA_CHANNEL_IRAM + 1)
-#else				/*CONFIG_SDMA_IRAM */
-#define MX51_MXC_DMA_CHANNEL_SSI2_TX	MXC_DMA_DYNAMIC_CHANNEL
-#endif				/*CONFIG_SDMA_IRAM */
-#define MX51_MXC_DMA_CHANNEL_CSPI1_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_CSPI1_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_CSPI2_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_CSPI2_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_CSPI3_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_CSPI3_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_ATA_RX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_ATA_TX	MXC_DMA_DYNAMIC_CHANNEL
-#define MX51_MXC_DMA_CHANNEL_MEMORY	MXC_DMA_DYNAMIC_CHANNEL
-
-#define MX51_IS_MEM_DEVICE_NONSHARED(x)		0
-
-/*
  * DMA request assignments
  */
 #define MX51_DMA_REQ_VPU		0
-- 
1.9.0
