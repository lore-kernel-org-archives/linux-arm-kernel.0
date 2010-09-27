From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:46 +0200
Subject: [PATCH 10/40] ARM: mx51: fix naming of spi related defines
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The names used now match the processor's reference manual.  Also remove
MXC from the interrupt defines to match the other imx platforms.

Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Jason Wang <jason77.wang@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx51.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 92b39f7..d0fda39 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -67,7 +67,7 @@
 #define MX51_MMC_SDHC1_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x04000)
 #define MX51_MMC_SDHC2_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x08000)
 #define MX51_UART3_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x0c000)
-#define MX51_CSPI1_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x10000)
+#define MX51_ECSPI1_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x10000)
 #define MX51_SSI2_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x14000)
 #define MX51_MMC_SDHC3_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x20000)
 #define MX51_MMC_SDHC4_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x24000)
@@ -121,12 +121,12 @@
 #define MX51_ARM_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xa0000)
 #define MX51_OWIRE_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xa4000)
 #define MX51_FIRI_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xa8000)
-#define MX51_CSPI2_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xac000)
+#define MX51_ECSPI2_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xac000)
 #define MX51_SDMA_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xb0000)
 #define MX51_SCC_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xb4000)
 #define MX51_ROMCP_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xb8000)
 #define MX51_RTIC_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xbc000)
-#define MX51_CSPI3_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xc0000)
+#define MX51_CSPI_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xc0000)
 #define MX51_I2C2_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xc4000)
 #define MX51_I2C1_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xc8000)
 #define MX51_SSI1_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xcc000)
@@ -346,9 +346,9 @@
 #define MX51_MXC_INT_UART3		33
 #define MX51_MXC_INT_RESV34		34
 #define MX51_MXC_INT_RESV35		35
-#define MX51_MXC_INT_CSPI1		36
-#define MX51_MXC_INT_CSPI2		37
-#define MX51_MXC_INT_CSPI		38
+#define MX51_INT_ECSPI1			36
+#define MX51_INT_ECSPI2			37
+#define MX51_INT_CSPI			38
 #define MX51_MXC_INT_GPT		39
 #define MX51_MXC_INT_EPIT1		40
 #define MX51_MXC_INT_EPIT2		41
-- 
1.7.2.3
