From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:15 +0000
Subject: [S3C-CLK] ARM: S3C64XX: Remove unused clock definitions from clock
	header
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harald Welte <laforge@gnumonks.org>

Clean out the definitions we are no longer using after the new clock
code updates.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
[ben-linux at fluff.org: split from initial patch provided]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h |   71 +----------------------
 1 files changed, 1 insertions(+), 70 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
index ff46e7f..3ef6274 100644
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
@@ -35,14 +35,6 @@
 #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
 
 /* CLKDIV0 */
-#define S3C6400_CLKDIV0_MFC_MASK	(0xf << 28)
-#define S3C6400_CLKDIV0_MFC_SHIFT	(28)
-#define S3C6400_CLKDIV0_JPEG_MASK	(0xf << 24)
-#define S3C6400_CLKDIV0_JPEG_SHIFT	(24)
-#define S3C6400_CLKDIV0_CAM_MASK	(0xf << 20)
-#define S3C6400_CLKDIV0_CAM_SHIFT	(20)
-#define S3C6400_CLKDIV0_SECURITY_MASK	(0x3 << 18)
-#define S3C6400_CLKDIV0_SECURITY_SHIFT	(18)
 #define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
 #define S3C6400_CLKDIV0_PCLK_SHIFT	(12)
 #define S3C6400_CLKDIV0_HCLK2_MASK	(0x7 << 9)
@@ -51,42 +43,11 @@
 #define S3C6400_CLKDIV0_HCLK_SHIFT	(8)
 #define S3C6400_CLKDIV0_MPLL_MASK	(0x1 << 4)
 #define S3C6400_CLKDIV0_MPLL_SHIFT	(4)
+
 #define S3C6400_CLKDIV0_ARM_MASK	(0x7 << 0)
 #define S3C6410_CLKDIV0_ARM_MASK	(0xf << 0)
 #define S3C6400_CLKDIV0_ARM_SHIFT	(0)
 
-/* CLKDIV1 */
-#define S3C6410_CLKDIV1_FIMC_MASK	(0xf << 24)
-#define S3C6410_CLKDIV1_FIMC_SHIFT	(24)
-#define S3C6400_CLKDIV1_UHOST_MASK	(0xf << 20)
-#define S3C6400_CLKDIV1_UHOST_SHIFT	(20)
-#define S3C6400_CLKDIV1_SCALER_MASK	(0xf << 16)
-#define S3C6400_CLKDIV1_SCALER_SHIFT	(16)
-#define S3C6400_CLKDIV1_LCD_MASK	(0xf << 12)
-#define S3C6400_CLKDIV1_LCD_SHIFT	(12)
-#define S3C6400_CLKDIV1_MMC2_MASK	(0xf << 8)
-#define S3C6400_CLKDIV1_MMC2_SHIFT	(8)
-#define S3C6400_CLKDIV1_MMC1_MASK	(0xf << 4)
-#define S3C6400_CLKDIV1_MMC1_SHIFT	(4)
-#define S3C6400_CLKDIV1_MMC0_MASK	(0xf << 0)
-#define S3C6400_CLKDIV1_MMC0_SHIFT	(0)
-
-/* CLKDIV2 */
-#define S3C6410_CLKDIV2_AUDIO2_MASK	(0xf << 24)
-#define S3C6410_CLKDIV2_AUDIO2_SHIFT	(24)
-#define S3C6400_CLKDIV2_IRDA_MASK	(0xf << 20)
-#define S3C6400_CLKDIV2_IRDA_SHIFT	(20)
-#define S3C6400_CLKDIV2_UART_MASK	(0xf << 16)
-#define S3C6400_CLKDIV2_UART_SHIFT	(16)
-#define S3C6400_CLKDIV2_AUDIO1_MASK	(0xf << 12)
-#define S3C6400_CLKDIV2_AUDIO1_SHIFT	(12)
-#define S3C6400_CLKDIV2_AUDIO0_MASK	(0xf << 8)
-#define S3C6400_CLKDIV2_AUDIO0_SHIFT	(8)
-#define S3C6400_CLKDIV2_SPI1_MASK	(0xf << 4)
-#define S3C6400_CLKDIV2_SPI1_SHIFT	(4)
-#define S3C6400_CLKDIV2_SPI0_MASK	(0xf << 0)
-#define S3C6400_CLKDIV2_SPI0_SHIFT	(0)
-
 /* HCLK GATE Registers */
 #define S3C_CLKCON_HCLK_3DSE	(1<<31)
 #define S3C_CLKCON_HCLK_UHOST	(1<<29)
@@ -192,34 +153,4 @@
 #define S3C6400_CLKSRC_EPLL_MOUT_SHIFT	(2)
 #define S3C6400_CLKSRC_MFC		(1 << 4)
 
-#define S3C6410_CLKSRC_TV27_MASK	(0x1 << 31)
-#define S3C6410_CLKSRC_TV27_SHIFT	(31)
-#define S3C6410_CLKSRC_DAC27_MASK	(0x1 << 30)
-#define S3C6410_CLKSRC_DAC27_SHIFT	(30)
-#define S3C6400_CLKSRC_SCALER_MASK	(0x3 << 28)
-#define S3C6400_CLKSRC_SCALER_SHIFT	(28)
-#define S3C6400_CLKSRC_LCD_MASK		(0x3 << 26)
-#define S3C6400_CLKSRC_LCD_SHIFT	(26)
-#define S3C6400_CLKSRC_IRDA_MASK	(0x3 << 24)
-#define S3C6400_CLKSRC_IRDA_SHIFT	(24)
-#define S3C6400_CLKSRC_MMC2_MASK	(0x3 << 22)
-#define S3C6400_CLKSRC_MMC2_SHIFT	(22)
-#define S3C6400_CLKSRC_MMC1_MASK	(0x3 << 20)
-#define S3C6400_CLKSRC_MMC1_SHIFT	(20)
-#define S3C6400_CLKSRC_MMC0_MASK	(0x3 << 18)
-#define S3C6400_CLKSRC_MMC0_SHIFT	(18)
-#define S3C6400_CLKSRC_SPI1_MASK	(0x3 << 16)
-#define S3C6400_CLKSRC_SPI1_SHIFT	(16)
-#define S3C6400_CLKSRC_SPI0_MASK	(0x3 << 14)
-#define S3C6400_CLKSRC_SPI0_SHIFT	(14)
-#define S3C6400_CLKSRC_UART_MASK	(0x1 << 13)
-#define S3C6400_CLKSRC_UART_SHIFT	(13)
-#define S3C6400_CLKSRC_AUDIO1_MASK	(0x7 << 10)
-#define S3C6400_CLKSRC_AUDIO1_SHIFT	(10)
-#define S3C6400_CLKSRC_AUDIO0_MASK	(0x7 << 7)
-#define S3C6400_CLKSRC_AUDIO0_SHIFT	(7)
-#define S3C6400_CLKSRC_UHOST_MASK	(0x3 << 5)
-#define S3C6400_CLKSRC_UHOST_SHIFT	(5)
-
-
 #endif /* _PLAT_REGS_CLOCK_H */
-- 
1.6.0.4
