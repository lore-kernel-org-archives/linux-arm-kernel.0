From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 28 Jul 2011 20:27:51 +0200
Subject: [PATCH 1/4 v2] ARM: s3c64xx: DMA: Use S3C64XX_SDMA_SEL register name
 instead of numeric address.
Message-ID: <mailman.93.1313970543.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a definition of S3C64XX_SDMA_SEL register and modifies
the s3c64xx DMA driver to use it instead of a magic register address.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/dma.c                   |    2 +-
 arch/arm/mach-s3c64xx/include/mach/regs-sys.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 204bfaf..0849f2d 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -740,7 +740,7 @@ static int __init s3c64xx_dma_init(void)
 	}
 
 	/* Set all DMA configuration to be DMA, not SDMA */
-	writel(0xffffff, S3C_SYSREG(0x110));
+	writel(0xffffff, S3C64XX_SDMA_SEL);
 
 	/* Register standard DMA controllers */
 	s3c64xx_dma_init1(0, DMACH_UART0, IRQ_DMA0, 0x75000000);
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
index 69b78d9..774e0de 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
@@ -21,6 +21,8 @@
 #define S3C64XX_AHB_CON1	S3C_SYSREG(0x104)
 #define S3C64XX_AHB_CON2	S3C_SYSREG(0x108)
 
+#define S3C64XX_SDMA_SEL	S3C_SYSREG(0x110)
+
 #define S3C64XX_OTHERS		S3C_SYSREG(0x900)
 
 #define S3C64XX_OTHERS_USBMASK	(1 << 16)
-- 
1.7.6
