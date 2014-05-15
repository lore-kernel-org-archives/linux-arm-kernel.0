From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 15 May 2014 09:57:51 +0200
Subject: [PATCH] ARM: imx: remove check for CONFIG_SDMA_IRAM
Message-ID: <1400140671.20469.7.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A check for CONFIG_SDMA_IRAM was added in v2.6.34. But the Kconfig
symbol SDMA_IRAM was never added. Remove this check.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

Note that none of the MX51_MXC_DMA_CHANNEL_* macros are actually used.
Why are they needed?

 arch/arm/mach-imx/mx51.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-imx/mx51.h b/arch/arm/mach-imx/mx51.h
index af844f76261a..f2604098fd06 100644
--- a/arch/arm/mach-imx/mx51.h
+++ b/arch/arm/mach-imx/mx51.h
@@ -160,11 +160,7 @@
 #define MX51_MXC_DMA_CHANNEL_SSI1_RX	MXC_DMA_DYNAMIC_CHANNEL
 #define MX51_MXC_DMA_CHANNEL_SSI1_TX	MXC_DMA_DYNAMIC_CHANNEL
 #define MX51_MXC_DMA_CHANNEL_SSI2_RX	MXC_DMA_DYNAMIC_CHANNEL
-#ifdef CONFIG_SDMA_IRAM
-#define MX51_MXC_DMA_CHANNEL_SSI2_TX	(MX51_MXC_DMA_CHANNEL_IRAM + 1)
-#else				/*CONFIG_SDMA_IRAM */
 #define MX51_MXC_DMA_CHANNEL_SSI2_TX	MXC_DMA_DYNAMIC_CHANNEL
-#endif				/*CONFIG_SDMA_IRAM */
 #define MX51_MXC_DMA_CHANNEL_CSPI1_RX	MXC_DMA_DYNAMIC_CHANNEL
 #define MX51_MXC_DMA_CHANNEL_CSPI1_TX	MXC_DMA_DYNAMIC_CHANNEL
 #define MX51_MXC_DMA_CHANNEL_CSPI2_RX	MXC_DMA_DYNAMIC_CHANNEL
-- 
1.9.0
