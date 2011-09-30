From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Sep 2011 21:55:37 +0900
Subject: [PATCH 2/3] ARM: SAMSUNG: Move S3C24XX header files to plat-samsung
Message-ID: <019501cc7f70$40579c90$c106d5b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves header files from plat-s3c24xx to plat-samsung to
remove plat-s3c24xx directory to make one plat-samsung directory for
Samsung SoCs. And this patch includes fixing coding style, too.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c24xx/include/plat/regs-iis.h      |   68 ----------
 arch/arm/plat-s3c24xx/include/plat/regs-spi.h      |   81 ------------
 .../include/plat/audio-simtec.h                    |    2 +-
 .../include/plat/common-smdk.h                     |    2 +-
 .../include/plat/cpu-freq-core.h                   |    5 +-
 .../include/plat/fiq.h                             |    2 +-
 .../include/plat/irq.h                             |   25 ++--
 .../include/plat/mci.h                             |   10 +-
 .../include/plat/regs-dma.h                        |  112 +++++++++--------
 arch/arm/plat-samsung/include/plat/regs-iis.h      |   70 +++++++++++
 arch/arm/plat-samsung/include/plat/regs-spi.h      |   48 +++++++
 .../include/plat/regs-udc.h                        |  132 ++++++++++----------
 .../include/plat/udc.h                             |    4 +-
 13 files changed, 268 insertions(+), 293 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/regs-iis.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/regs-spi.h
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/audio-simtec.h (95%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/common-smdk.h (87%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/cpu-freq-core.h (98%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/fiq.h (88%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/irq.h (81%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/mci.h (90%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/regs-dma.h (58%)
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-iis.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-spi.h
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/regs-udc.h (51%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/udc.h (95%)

diff --git a/arch/arm/plat-s3c24xx/include/plat/regs-iis.h b/arch/arm/plat-s3c24xx/include/plat/regs-iis.h
deleted file mode 100644
index cc44e0e..0000000
--- a/arch/arm/plat-s3c24xx/include/plat/regs-iis.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-iis.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 IIS register definition
-*/
-
-#ifndef __ASM_ARCH_REGS_IIS_H
-#define __ASM_ARCH_REGS_IIS_H
-
-#define S3C2410_IISCON	 (0x00)
-
-#define S3C2410_IISCON_LRINDEX	  (1<<8)
-#define S3C2410_IISCON_TXFIFORDY  (1<<7)
-#define S3C2410_IISCON_RXFIFORDY  (1<<6)
-#define S3C2410_IISCON_TXDMAEN	  (1<<5)
-#define S3C2410_IISCON_RXDMAEN	  (1<<4)
-#define S3C2410_IISCON_TXIDLE	  (1<<3)
-#define S3C2410_IISCON_RXIDLE	  (1<<2)
-#define S3C2410_IISCON_PSCEN	  (1<<1)
-#define S3C2410_IISCON_IISEN	  (1<<0)
-
-#define S3C2410_IISMOD	 (0x04)
-
-#define S3C2440_IISMOD_MPLL	  (1<<9)
-#define S3C2410_IISMOD_SLAVE	  (1<<8)
-#define S3C2410_IISMOD_NOXFER	  (0<<6)
-#define S3C2410_IISMOD_RXMODE	  (1<<6)
-#define S3C2410_IISMOD_TXMODE	  (2<<6)
-#define S3C2410_IISMOD_TXRXMODE	  (3<<6)
-#define S3C2410_IISMOD_LR_LLOW	  (0<<5)
-#define S3C2410_IISMOD_LR_RLOW	  (1<<5)
-#define S3C2410_IISMOD_IIS	  (0<<4)
-#define S3C2410_IISMOD_MSB	  (1<<4)
-#define S3C2410_IISMOD_8BIT	  (0<<3)
-#define S3C2410_IISMOD_16BIT	  (1<<3)
-#define S3C2410_IISMOD_BITMASK	  (1<<3)
-#define S3C2410_IISMOD_256FS	  (0<<2)
-#define S3C2410_IISMOD_384FS	  (1<<2)
-#define S3C2410_IISMOD_16FS	  (0<<0)
-#define S3C2410_IISMOD_32FS	  (1<<0)
-#define S3C2410_IISMOD_48FS	  (2<<0)
-#define S3C2410_IISMOD_FS_MASK	  (3<<0)
-
-#define S3C2410_IISPSR		(0x08)
-#define S3C2410_IISPSR_INTMASK	(31<<5)
-#define S3C2410_IISPSR_INTSHIFT	(5)
-#define S3C2410_IISPSR_EXTMASK	(31<<0)
-#define S3C2410_IISPSR_EXTSHFIT	(0)
-
-#define S3C2410_IISFCON  (0x0c)
-
-#define S3C2410_IISFCON_TXDMA	  (1<<15)
-#define S3C2410_IISFCON_RXDMA	  (1<<14)
-#define S3C2410_IISFCON_TXENABLE  (1<<13)
-#define S3C2410_IISFCON_RXENABLE  (1<<12)
-#define S3C2410_IISFCON_TXMASK	  (0x3f << 6)
-#define S3C2410_IISFCON_TXSHIFT	  (6)
-#define S3C2410_IISFCON_RXMASK	  (0x3f)
-#define S3C2410_IISFCON_RXSHIFT	  (0)
-
-#define S3C2410_IISFIFO  (0x10)
-#endif /* __ASM_ARCH_REGS_IIS_H */
diff --git a/arch/arm/plat-s3c24xx/include/plat/regs-spi.h b/arch/arm/plat-s3c24xx/include/plat/regs-spi.h
deleted file mode 100644
index 892e2f6..0000000
--- a/arch/arm/plat-s3c24xx/include/plat/regs-spi.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-spi.h
- *
- * Copyright (c) 2004 Fetron GmbH
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 SPI register definition
-*/
-
-#ifndef __ASM_ARCH_REGS_SPI_H
-#define __ASM_ARCH_REGS_SPI_H
-
-#define S3C2410_SPI1	(0x20)
-#define S3C2412_SPI1	(0x100)
-
-#define S3C2410_SPCON	(0x00)
-
-#define S3C2412_SPCON_RXFIFO_RB2	(0<<14)
-#define S3C2412_SPCON_RXFIFO_RB4	(1<<14)
-#define S3C2412_SPCON_RXFIFO_RB12	(2<<14)
-#define S3C2412_SPCON_RXFIFO_RB14	(3<<14)
-#define S3C2412_SPCON_TXFIFO_RB2	(0<<12)
-#define S3C2412_SPCON_TXFIFO_RB4	(1<<12)
-#define S3C2412_SPCON_TXFIFO_RB12	(2<<12)
-#define S3C2412_SPCON_TXFIFO_RB14	(3<<12)
-#define S3C2412_SPCON_RXFIFO_RESET	(1<<11) /* RxFIFO reset */
-#define S3C2412_SPCON_TXFIFO_RESET	(1<<10) /* TxFIFO reset */
-#define S3C2412_SPCON_RXFIFO_EN		(1<<9)  /* RxFIFO Enable */
-#define S3C2412_SPCON_TXFIFO_EN		(1<<8)  /* TxFIFO Enable */
-
-#define S3C2412_SPCON_DIRC_RX	  (1<<7)
-
-#define S3C2410_SPCON_SMOD_DMA	  (2<<5)	/* DMA mode */
-#define S3C2410_SPCON_SMOD_INT	  (1<<5)	/* interrupt mode */
-#define S3C2410_SPCON_SMOD_POLL   (0<<5)	/* polling mode */
-#define S3C2410_SPCON_ENSCK	  (1<<4)	/* Enable SCK */
-#define S3C2410_SPCON_MSTR	  (1<<3)	/* Master/Slave select
-						   0: slave, 1: master */
-#define S3C2410_SPCON_CPOL_HIGH	  (1<<2)	/* Clock polarity select */
-#define S3C2410_SPCON_CPOL_LOW	  (0<<2)	/* Clock polarity select */
-
-#define S3C2410_SPCON_CPHA_FMTB	  (1<<1)	/* Clock Phase Select */
-#define S3C2410_SPCON_CPHA_FMTA	  (0<<1)	/* Clock Phase Select */
-
-#define S3C2410_SPCON_TAGD	  (1<<0)	/* Tx auto garbage data mode */
-
-
-#define S3C2410_SPSTA	 (0x04)
-
-#define S3C2412_SPSTA_RXFIFO_AE		(1<<11)
-#define S3C2412_SPSTA_TXFIFO_AE		(1<<10)
-#define S3C2412_SPSTA_RXFIFO_ERROR	(1<<9)
-#define S3C2412_SPSTA_TXFIFO_ERROR	(1<<8)
-#define S3C2412_SPSTA_RXFIFO_FIFO	(1<<7)
-#define S3C2412_SPSTA_RXFIFO_EMPTY	(1<<6)
-#define S3C2412_SPSTA_TXFIFO_NFULL	(1<<5)
-#define S3C2412_SPSTA_TXFIFO_EMPTY	(1<<4)
-
-#define S3C2410_SPSTA_DCOL	  (1<<2)	/* Data Collision Error */
-#define S3C2410_SPSTA_MULD	  (1<<1)	/* Multi Master Error */
-#define S3C2410_SPSTA_READY	  (1<<0)	/* Data Tx/Rx ready */
-#define S3C2412_SPSTA_READY_ORG	  (1<<3)
-
-#define S3C2410_SPPIN	 (0x08)
-
-#define S3C2410_SPPIN_ENMUL	  (1<<2)	/* Multi Master Error detect */
-#define S3C2410_SPPIN_RESERVED	  (1<<1)
-#define S3C2410_SPPIN_KEEP	  (1<<0)	/* Master Out keep */
-
-#define S3C2410_SPPRE	 (0x0C)
-#define S3C2410_SPTDAT	 (0x10)
-#define S3C2410_SPRDAT	 (0x14)
-
-#define S3C2412_TXFIFO	 (0x18)
-#define S3C2412_RXFIFO	 (0x18)
-#define S3C2412_SPFIC	 (0x24)
-
-
-#endif /* __ASM_ARCH_REGS_SPI_H */
diff --git a/arch/arm/plat-s3c24xx/include/plat/audio-simtec.h b/arch/arm/plat-samsung/include/plat/audio-simtec.h
similarity index 95%
rename from arch/arm/plat-s3c24xx/include/plat/audio-simtec.h
rename to arch/arm/plat-samsung/include/plat/audio-simtec.h
index de5e88f..5345364 100644
--- a/arch/arm/plat-s3c24xx/include/plat/audio-simtec.h
+++ b/arch/arm/plat-samsung/include/plat/audio-simtec.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c24xx/include/plat/audio-simtec.h
+/* arch/arm/plat-samsung/include/plat/audio-simtec.h
  *
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
diff --git a/arch/arm/plat-s3c24xx/include/plat/common-smdk.h b/arch/arm/plat-samsung/include/plat/common-smdk.h
similarity index 87%
rename from arch/arm/plat-s3c24xx/include/plat/common-smdk.h
rename to arch/arm/plat-samsung/include/plat/common-smdk.h
index 58d9094..ba028f1 100644
--- a/arch/arm/plat-s3c24xx/include/plat/common-smdk.h
+++ b/arch/arm/plat-samsung/include/plat/common-smdk.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/common-smdk.h
+/* linux/arch/arm/plat-samsung/include/plat/common-smdk.h
  *
  * Copyright (c) 2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
similarity index 98%
rename from arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h
rename to arch/arm/plat-samsung/include/plat/cpu-freq-core.h
index d623235..dac4760 100644
--- a/arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c/include/plat/cpu-freq.h
+/* arch/arm/plat-samsung/include/plat/cpu-freq-core.h
  *
  * Copyright (c) 2006-2009 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
@@ -195,7 +195,8 @@ struct s3c_cpufreq_info {
 
 extern int s3c_cpufreq_register(struct s3c_cpufreq_info *info);
 
-extern int s3c_plltab_register(struct cpufreq_frequency_table *plls, unsigned int plls_no);
+extern int s3c_plltab_register(struct cpufreq_frequency_table *plls,
+			       unsigned int plls_no);
 
 /* exports and utilities for debugfs */
 extern struct s3c_cpufreq_config *s3c_cpufreq_getconfig(void);
diff --git a/arch/arm/plat-s3c24xx/include/plat/fiq.h b/arch/arm/plat-samsung/include/plat/fiq.h
similarity index 88%
rename from arch/arm/plat-s3c24xx/include/plat/fiq.h
rename to arch/arm/plat-samsung/include/plat/fiq.h
index 8521b83..535d06a 100644
--- a/arch/arm/plat-s3c24xx/include/plat/fiq.h
+++ b/arch/arm/plat-samsung/include/plat/fiq.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/fiq.h
+/* linux/arch/arm/plat-samsung/include/plat/fiq.h
  *
  * Copyright (c) 2009 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/include/plat/irq.h b/arch/arm/plat-samsung/include/plat/irq.h
similarity index 81%
rename from arch/arm/plat-s3c24xx/include/plat/irq.h
rename to arch/arm/plat-samsung/include/plat/irq.h
index ec087d6..e21a89b 100644
--- a/arch/arm/plat-s3c24xx/include/plat/irq.h
+++ b/arch/arm/plat-samsung/include/plat/irq.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/irq.h
+/* linux/arch/arm/plat-samsung/include/plat/irq.h
  *
  * Copyright (c) 2004-2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
@@ -25,9 +25,9 @@
 extern struct irq_chip s3c_irq_level_chip;
 extern struct irq_chip s3c_irq_chip;
 
-static inline void
-s3c_irqsub_mask(unsigned int irqno, unsigned int parentbit,
-		int subcheck)
+static inline void s3c_irqsub_mask(unsigned int irqno,
+				   unsigned int parentbit,
+				   int subcheck)
 {
 	unsigned long mask;
 	unsigned long submask;
@@ -39,17 +39,16 @@ s3c_irqsub_mask(unsigned int irqno, unsigned int parentbit,
 
 	/* check to see if we need to mask the parent IRQ */
 
-	if ((submask  & subcheck) == subcheck) {
+	if ((submask  & subcheck) == subcheck)
 		__raw_writel(mask | parentbit, S3C2410_INTMSK);
-	}
 
 	/* write back masks */
 	__raw_writel(submask, S3C2410_INTSUBMSK);
 
 }
 
-static inline void
-s3c_irqsub_unmask(unsigned int irqno, unsigned int parentbit)
+static inline void s3c_irqsub_unmask(unsigned int irqno,
+				     unsigned int parentbit)
 {
 	unsigned long mask;
 	unsigned long submask;
@@ -66,8 +65,9 @@ s3c_irqsub_unmask(unsigned int irqno, unsigned int parentbit)
 }
 
 
-static inline void
-s3c_irqsub_maskack(unsigned int irqno, unsigned int parentmask, unsigned int group)
+static inline void s3c_irqsub_maskack(unsigned int irqno,
+				      unsigned int parentmask,
+				      unsigned int group)
 {
 	unsigned int bit = 1UL << (irqno - IRQ_S3CUART_RX0);
 
@@ -86,8 +86,9 @@ s3c_irqsub_maskack(unsigned int irqno, unsigned int parentmask, unsigned int gro
 	}
 }
 
-static inline void
-s3c_irqsub_ack(unsigned int irqno, unsigned int parentmask, unsigned int group)
+static inline void s3c_irqsub_ack(unsigned int irqno,
+				  unsigned int parentmask,
+				  unsigned int group)
 {
 	unsigned int bit = 1UL << (irqno - IRQ_S3CUART_RX0);
 
diff --git a/arch/arm/plat-s3c24xx/include/plat/mci.h b/arch/arm/plat-samsung/include/plat/mci.h
similarity index 90%
rename from arch/arm/plat-s3c24xx/include/plat/mci.h
rename to arch/arm/plat-samsung/include/plat/mci.h
index 2ac2b21..c42d317 100644
--- a/arch/arm/plat-s3c24xx/include/plat/mci.h
+++ b/arch/arm/plat-samsung/include/plat/mci.h
@@ -27,11 +27,11 @@
  * to a non-zero value, otherwise the default of 3.2-3.4V is used.
  */
 struct s3c24xx_mci_pdata {
-	unsigned int	no_wprotect : 1;
-	unsigned int	no_detect : 1;
-	unsigned int	wprotect_invert : 1;
-	unsigned int	detect_invert : 1;   /* set => detect active high. */
-	unsigned int	use_dma : 1;
+	unsigned int	no_wprotect:1;
+	unsigned int	no_detect:1;
+	unsigned int	wprotect_invert:1;
+	unsigned int	detect_invert:1;	/* set => detect active high */
+	unsigned int	use_dma:1;
 
 	unsigned int	gpio_detect;
 	unsigned int	gpio_wprotect;
diff --git a/arch/arm/plat-s3c24xx/include/plat/regs-dma.h b/arch/arm/plat-samsung/include/plat/regs-dma.h
similarity index 58%
rename from arch/arm/plat-s3c24xx/include/plat/regs-dma.h
rename to arch/arm/plat-samsung/include/plat/regs-dma.h
index 1b0f4c3..178bccb 100644
--- a/arch/arm/plat-s3c24xx/include/plat/regs-dma.h
+++ b/arch/arm/plat-samsung/include/plat/regs-dma.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/dma.h
+/* arch/arm/plat-samsung/include/plat/regs-dma.h
  *
  * Copyright (C) 2003-2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
@@ -10,7 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-/* DMA Register definitions */
+#ifndef __ASM_PLAT_REGS_DMA_H
+#define __ASM_PLAT_REGS_DMA_H __FILE__
 
 #define S3C2410_DMA_DISRC		(0x00)
 #define S3C2410_DMA_DISRCC		(0x04)
@@ -24,74 +25,75 @@
 #define S3C2412_DMA_DMAREQSEL		(0x24)
 #define S3C2443_DMA_DMAREQSEL		(0x24)
 
-#define S3C2410_DISRCC_INC		(1<<0)
-#define S3C2410_DISRCC_APB		(1<<1)
+#define S3C2410_DISRCC_INC		(1 << 0)
+#define S3C2410_DISRCC_APB		(1 << 1)
 
-#define S3C2410_DMASKTRIG_STOP		(1<<2)
-#define S3C2410_DMASKTRIG_ON		(1<<1)
-#define S3C2410_DMASKTRIG_SWTRIG	(1<<0)
+#define S3C2410_DMASKTRIG_STOP		(1 << 2)
+#define S3C2410_DMASKTRIG_ON		(1 << 1)
+#define S3C2410_DMASKTRIG_SWTRIG	(1 << 0)
 
-#define S3C2410_DCON_DEMAND		(0<<31)
-#define S3C2410_DCON_HANDSHAKE		(1<<31)
-#define S3C2410_DCON_SYNC_PCLK		(0<<30)
-#define S3C2410_DCON_SYNC_HCLK		(1<<30)
+#define S3C2410_DCON_DEMAND		(0 << 31)
+#define S3C2410_DCON_HANDSHAKE		(1 << 31)
+#define S3C2410_DCON_SYNC_PCLK		(0 << 30)
+#define S3C2410_DCON_SYNC_HCLK		(1 << 30)
 
-#define S3C2410_DCON_INTREQ		(1<<29)
+#define S3C2410_DCON_INTREQ		(1 << 29)
 
-#define S3C2410_DCON_CH0_XDREQ0		(0<<24)
-#define S3C2410_DCON_CH0_UART0		(1<<24)
-#define S3C2410_DCON_CH0_SDI		(2<<24)
-#define S3C2410_DCON_CH0_TIMER		(3<<24)
-#define S3C2410_DCON_CH0_USBEP1		(4<<24)
+#define S3C2410_DCON_CH0_XDREQ0		(0 << 24)
+#define S3C2410_DCON_CH0_UART0		(1 << 24)
+#define S3C2410_DCON_CH0_SDI		(2 << 24)
+#define S3C2410_DCON_CH0_TIMER		(3 << 24)
+#define S3C2410_DCON_CH0_USBEP1		(4 << 24)
 
-#define S3C2410_DCON_CH1_XDREQ1		(0<<24)
-#define S3C2410_DCON_CH1_UART1		(1<<24)
-#define S3C2410_DCON_CH1_I2SSDI		(2<<24)
-#define S3C2410_DCON_CH1_SPI		(3<<24)
-#define S3C2410_DCON_CH1_USBEP2		(4<<24)
+#define S3C2410_DCON_CH1_XDREQ1		(0 << 24)
+#define S3C2410_DCON_CH1_UART1		(1 << 24)
+#define S3C2410_DCON_CH1_I2SSDI		(2 << 24)
+#define S3C2410_DCON_CH1_SPI		(3 << 24)
+#define S3C2410_DCON_CH1_USBEP2		(4 << 24)
 
-#define S3C2410_DCON_CH2_I2SSDO		(0<<24)
-#define S3C2410_DCON_CH2_I2SSDI		(1<<24)
-#define S3C2410_DCON_CH2_SDI		(2<<24)
-#define S3C2410_DCON_CH2_TIMER		(3<<24)
-#define S3C2410_DCON_CH2_USBEP3		(4<<24)
+#define S3C2410_DCON_CH2_I2SSDO		(0 << 24)
+#define S3C2410_DCON_CH2_I2SSDI		(1 << 24)
+#define S3C2410_DCON_CH2_SDI		(2 << 24)
+#define S3C2410_DCON_CH2_TIMER		(3 << 24)
+#define S3C2410_DCON_CH2_USBEP3		(4 << 24)
 
-#define S3C2410_DCON_CH3_UART2		(0<<24)
-#define S3C2410_DCON_CH3_SDI		(1<<24)
-#define S3C2410_DCON_CH3_SPI		(2<<24)
-#define S3C2410_DCON_CH3_TIMER		(3<<24)
-#define S3C2410_DCON_CH3_USBEP4		(4<<24)
+#define S3C2410_DCON_CH3_UART2		(0 << 24)
+#define S3C2410_DCON_CH3_SDI		(1 << 24)
+#define S3C2410_DCON_CH3_SPI		(2 << 24)
+#define S3C2410_DCON_CH3_TIMER		(3 << 24)
+#define S3C2410_DCON_CH3_USBEP4		(4 << 24)
 
 #define S3C2410_DCON_SRCSHIFT		(24)
-#define S3C2410_DCON_SRCMASK		(7<<24)
+#define S3C2410_DCON_SRCMASK		(7 << 24)
 
-#define S3C2410_DCON_BYTE		(0<<20)
-#define S3C2410_DCON_HALFWORD		(1<<20)
-#define S3C2410_DCON_WORD		(2<<20)
+#define S3C2410_DCON_BYTE		(0 << 20)
+#define S3C2410_DCON_HALFWORD		(1 << 20)
+#define S3C2410_DCON_WORD		(2 << 20)
 
-#define S3C2410_DCON_AUTORELOAD		(0<<22)
-#define S3C2410_DCON_NORELOAD		(1<<22)
-#define S3C2410_DCON_HWTRIG		(1<<23)
+#define S3C2410_DCON_AUTORELOAD		(0 << 22)
+#define S3C2410_DCON_NORELOAD		(1 << 22)
+#define S3C2410_DCON_HWTRIG		(1 << 23)
 
 #ifdef CONFIG_CPU_S3C2440
-#define S3C2440_DIDSTC_CHKINT		(1<<2)
 
-#define S3C2440_DCON_CH0_I2SSDO		(5<<24)
-#define S3C2440_DCON_CH0_PCMIN		(6<<24)
+#define S3C2440_DIDSTC_CHKINT		(1 << 2)
 
-#define S3C2440_DCON_CH1_PCMOUT		(5<<24)
-#define S3C2440_DCON_CH1_SDI		(6<<24)
+#define S3C2440_DCON_CH0_I2SSDO		(5 << 24)
+#define S3C2440_DCON_CH0_PCMIN		(6 << 24)
 
-#define S3C2440_DCON_CH2_PCMIN		(5<<24)
-#define S3C2440_DCON_CH2_MICIN		(6<<24)
+#define S3C2440_DCON_CH1_PCMOUT		(5 << 24)
+#define S3C2440_DCON_CH1_SDI		(6 << 24)
 
-#define S3C2440_DCON_CH3_MICIN		(5<<24)
-#define S3C2440_DCON_CH3_PCMOUT		(6<<24)
-#endif
+#define S3C2440_DCON_CH2_PCMIN		(5 << 24)
+#define S3C2440_DCON_CH2_MICIN		(6 << 24)
+
+#define S3C2440_DCON_CH3_MICIN		(5 << 24)
+#define S3C2440_DCON_CH3_PCMOUT		(6 << 24)
+#endif /* CONFIG_CPU_S3C2440 */
 
 #ifdef CONFIG_CPU_S3C2412
 
-#define S3C2412_DMAREQSEL_SRC(x)	((x)<<1)
+#define S3C2412_DMAREQSEL_SRC(x)	((x) << 1)
 
 #define S3C2412_DMAREQSEL_HW		(1)
 
@@ -115,10 +117,11 @@
 #define S3C2412_DMAREQSEL_UART1_1	S3C2412_DMAREQSEL_SRC(22)
 #define S3C2412_DMAREQSEL_UART2_0	S3C2412_DMAREQSEL_SRC(23)
 #define S3C2412_DMAREQSEL_UART2_1	S3C2412_DMAREQSEL_SRC(24)
+#endif /* CONFIG_CPU_S3C2412 */
 
-#endif
+#ifdef CONFIG_CPU_S3C2443
 
-#define S3C2443_DMAREQSEL_SRC(x)	((x)<<1)
+#define S3C2443_DMAREQSEL_SRC(x)	((x) << 1)
 
 #define S3C2443_DMAREQSEL_HW		(1)
 
@@ -141,5 +144,8 @@
 #define S3C2443_DMAREQSEL_UART3_0	S3C2443_DMAREQSEL_SRC(25)
 #define S3C2443_DMAREQSEL_UART3_1	S3C2443_DMAREQSEL_SRC(26)
 #define S3C2443_DMAREQSEL_PCMOUT	S3C2443_DMAREQSEL_SRC(27)
-#define S3C2443_DMAREQSEL_PCMIN 	S3C2443_DMAREQSEL_SRC(28)
+#define S3C2443_DMAREQSEL_PCMIN		S3C2443_DMAREQSEL_SRC(28)
 #define S3C2443_DMAREQSEL_MICIN		S3C2443_DMAREQSEL_SRC(29)
+#endif /* CONFIG_CPU_S3C2443 */
+
+#endif /* __ASM_PLAT_REGS_DMA_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-iis.h b/arch/arm/plat-samsung/include/plat/regs-iis.h
new file mode 100644
index 0000000..a18d35e
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-iis.h
@@ -0,0 +1,70 @@
+/* arch/arm/plat-samsung/include/plat/regs-iis.h
+ *
+ * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
+ *		      http://www.simtec.co.uk/products/SWLINUX/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2410 IIS register definition
+*/
+
+#ifndef __ASM_ARCH_REGS_IIS_H
+#define __ASM_ARCH_REGS_IIS_H
+
+#define S3C2410_IISCON			(0x00)
+
+#define S3C2410_IISCON_LRINDEX		(1 << 8)
+#define S3C2410_IISCON_TXFIFORDY	(1 << 7)
+#define S3C2410_IISCON_RXFIFORDY	(1 << 6)
+#define S3C2410_IISCON_TXDMAEN		(1 << 5)
+#define S3C2410_IISCON_RXDMAEN		(1 << 4)
+#define S3C2410_IISCON_TXIDLE		(1 << 3)
+#define S3C2410_IISCON_RXIDLE		(1 << 2)
+#define S3C2410_IISCON_PSCEN		(1 << 1)
+#define S3C2410_IISCON_IISEN		(1 << 0)
+
+#define S3C2410_IISMOD			(0x04)
+
+#define S3C2440_IISMOD_MPLL		(1 << 9)
+#define S3C2410_IISMOD_SLAVE		(1 << 8)
+#define S3C2410_IISMOD_NOXFER		(0 << 6)
+#define S3C2410_IISMOD_RXMODE		(1 << 6)
+#define S3C2410_IISMOD_TXMODE		(2 << 6)
+#define S3C2410_IISMOD_TXRXMODE		(3 << 6)
+#define S3C2410_IISMOD_LR_LLOW		(0 << 5)
+#define S3C2410_IISMOD_LR_RLOW		(1 << 5)
+#define S3C2410_IISMOD_IIS		(0 << 4)
+#define S3C2410_IISMOD_MSB		(1 << 4)
+#define S3C2410_IISMOD_8BIT		(0 << 3)
+#define S3C2410_IISMOD_16BIT		(1 << 3)
+#define S3C2410_IISMOD_BITMASK		(1 << 3)
+#define S3C2410_IISMOD_256FS		(0 << 2)
+#define S3C2410_IISMOD_384FS		(1 << 2)
+#define S3C2410_IISMOD_16FS		(0 << 0)
+#define S3C2410_IISMOD_32FS		(1 << 0)
+#define S3C2410_IISMOD_48FS		(2 << 0)
+#define S3C2410_IISMOD_FS_MASK		(3 << 0)
+
+#define S3C2410_IISPSR			(0x08)
+
+#define S3C2410_IISPSR_INTMASK		(31 << 5)
+#define S3C2410_IISPSR_INTSHIFT		(5)
+#define S3C2410_IISPSR_EXTMASK		(31 << 0)
+#define S3C2410_IISPSR_EXTSHFIT		(0)
+
+#define S3C2410_IISFCON			(0x0c)
+
+#define S3C2410_IISFCON_TXDMA		(1 << 15)
+#define S3C2410_IISFCON_RXDMA		(1 << 14)
+#define S3C2410_IISFCON_TXENABLE	(1 << 13)
+#define S3C2410_IISFCON_RXENABLE	(1 << 12)
+#define S3C2410_IISFCON_TXMASK		(0x3f << 6)
+#define S3C2410_IISFCON_TXSHIFT		(6)
+#define S3C2410_IISFCON_RXMASK		(0x3f)
+#define S3C2410_IISFCON_RXSHIFT		(0)
+
+#define S3C2410_IISFIFO			(0x10)
+
+#endif /* __ASM_ARCH_REGS_IIS_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-spi.h b/arch/arm/plat-samsung/include/plat/regs-spi.h
new file mode 100644
index 0000000..552fe7c
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-spi.h
@@ -0,0 +1,48 @@
+/* arch/arm/plat-samsung/include/plat/regs-spi.h
+ *
+ * Copyright (c) 2004 Fetron GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2410 SPI register definition
+*/
+
+#ifndef __ASM_ARCH_REGS_SPI_H
+#define __ASM_ARCH_REGS_SPI_H
+
+#define S3C2410_SPI1		(0x20)
+#define S3C2412_SPI1		(0x100)
+
+#define S3C2410_SPCON		(0x00)
+
+#define S3C2410_SPCON_SMOD_DMA	(2 << 5)	/* DMA mode */
+#define S3C2410_SPCON_SMOD_INT	(1 << 5)	/* interrupt mode */
+#define S3C2410_SPCON_SMOD_POLL	(0 << 5)	/* polling mode */
+#define S3C2410_SPCON_ENSCK	(1 << 4)	/* Enable SCK */
+#define S3C2410_SPCON_MSTR	(1 << 3)	/* Master:1, Slave:0 select */
+#define S3C2410_SPCON_CPOL_HIGH	(1 << 2)	/* Clock polarity select */
+#define S3C2410_SPCON_CPOL_LOW	(0 << 2)	/* Clock polarity select */
+
+#define S3C2410_SPCON_CPHA_FMTB	(1 << 1)	/* Clock Phase Select */
+#define S3C2410_SPCON_CPHA_FMTA	(0 << 1)	/* Clock Phase Select */
+
+#define S3C2410_SPSTA		(0x04)
+
+#define S3C2410_SPSTA_DCOL	(1 << 2)	/* Data Collision Error */
+#define S3C2410_SPSTA_MULD	(1 << 1)	/* Multi Master Error */
+#define S3C2410_SPSTA_READY	(1 << 0)	/* Data Tx/Rx ready */
+#define S3C2412_SPSTA_READY_ORG	(1 << 3)
+
+#define S3C2410_SPPIN		(0x08)
+
+#define S3C2410_SPPIN_ENMUL	(1 << 2)	/* Multi Master Error detect */
+#define S3C2410_SPPIN_RESERVED	(1 << 1)
+#define S3C2410_SPPIN_KEEP	(1 << 0)	/* Master Out keep */
+
+#define S3C2410_SPPRE		(0x0C)
+#define S3C2410_SPTDAT		(0x10)
+#define S3C2410_SPRDAT		(0x14)
+
+#endif /* __ASM_ARCH_REGS_SPI_H */
diff --git a/arch/arm/plat-s3c24xx/include/plat/regs-udc.h b/arch/arm/plat-samsung/include/plat/regs-udc.h
similarity index 51%
rename from arch/arm/plat-s3c24xx/include/plat/regs-udc.h
rename to arch/arm/plat-samsung/include/plat/regs-udc.h
index f0dd4a4..4003d3d 100644
--- a/arch/arm/plat-s3c24xx/include/plat/regs-udc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-udc.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-udc.h
+/* arch/arm/plat-samsung/include/plat/regs-udc.h
  *
  * Copyright (C) 2004 Herbert Poetzl <herbert@13thfloor.at>
  *
@@ -75,79 +75,77 @@
 #define S3C2410_UDC_OUT_FIFO_CNT1_REG	S3C2410_USBDREG(0x0198)
 #define S3C2410_UDC_OUT_FIFO_CNT2_REG	S3C2410_USBDREG(0x019c)
 
-#define S3C2410_UDC_FUNCADDR_UPDATE	(1<<7)
+#define S3C2410_UDC_FUNCADDR_UPDATE	(1 << 7)
 
-#define S3C2410_UDC_PWR_ISOUP		(1<<7) // R/W
-#define S3C2410_UDC_PWR_RESET		(1<<3) // R
-#define S3C2410_UDC_PWR_RESUME		(1<<2) // R/W
-#define S3C2410_UDC_PWR_SUSPEND		(1<<1) // R
-#define S3C2410_UDC_PWR_ENSUSPEND	(1<<0) // R/W
+#define S3C2410_UDC_PWR_ISOUP		(1 << 7) /* R/W */
+#define S3C2410_UDC_PWR_RESET		(1 << 3) /* R   */
+#define S3C2410_UDC_PWR_RESUME		(1 << 2) /* R/W */
+#define S3C2410_UDC_PWR_SUSPEND		(1 << 1) /* R   */
+#define S3C2410_UDC_PWR_ENSUSPEND	(1 << 0) /* R/W */
 
-#define S3C2410_UDC_PWR_DEFAULT		0x00
+#define S3C2410_UDC_PWR_DEFAULT		(0x00)
 
-#define S3C2410_UDC_INT_EP4		(1<<4) // R/W (clear only)
-#define S3C2410_UDC_INT_EP3		(1<<3) // R/W (clear only)
-#define S3C2410_UDC_INT_EP2		(1<<2) // R/W (clear only)
-#define S3C2410_UDC_INT_EP1		(1<<1) // R/W (clear only)
-#define S3C2410_UDC_INT_EP0		(1<<0) // R/W (clear only)
+#define S3C2410_UDC_INT_EP4		(1 << 4) /* R/W (clear only) */
+#define S3C2410_UDC_INT_EP3		(1 << 3) /* R/W (clear only) */
+#define S3C2410_UDC_INT_EP2		(1 << 2) /* R/W (clear only) */
+#define S3C2410_UDC_INT_EP1		(1 << 1) /* R/W (clear only) */
+#define S3C2410_UDC_INT_EP0		(1 << 0) /* R/W (clear only) */
 
-#define S3C2410_UDC_USBINT_RESET	(1<<2) // R/W (clear only)
-#define S3C2410_UDC_USBINT_RESUME	(1<<1) // R/W (clear only)
-#define S3C2410_UDC_USBINT_SUSPEND	(1<<0) // R/W (clear only)
+#define S3C2410_UDC_USBINT_RESET	(1 << 2) /* R/W (clear only) */
+#define S3C2410_UDC_USBINT_RESUME	(1 << 1) /* R/W (clear only) */
+#define S3C2410_UDC_USBINT_SUSPEND	(1 << 0) /* R/W (clear only) */
 
-#define S3C2410_UDC_INTE_EP4		(1<<4) // R/W
-#define S3C2410_UDC_INTE_EP3		(1<<3) // R/W
-#define S3C2410_UDC_INTE_EP2		(1<<2) // R/W
-#define S3C2410_UDC_INTE_EP1		(1<<1) // R/W
-#define S3C2410_UDC_INTE_EP0		(1<<0) // R/W
-
-#define S3C2410_UDC_USBINTE_RESET	(1<<2) // R/W
-#define S3C2410_UDC_USBINTE_SUSPEND	(1<<0) // R/W
+#define S3C2410_UDC_INTE_EP4		(1 << 4) /* R/W */
+#define S3C2410_UDC_INTE_EP3		(1 << 3) /* R/W */
+#define S3C2410_UDC_INTE_EP2		(1 << 2) /* R/W */
+#define S3C2410_UDC_INTE_EP1		(1 << 1) /* R/W */
+#define S3C2410_UDC_INTE_EP0		(1 << 0) /* R/W */
 
+#define S3C2410_UDC_USBINTE_RESET	(1 << 2) /* R/W */
+#define S3C2410_UDC_USBINTE_SUSPEND	(1 << 0) /* R/W */
 
 #define S3C2410_UDC_INDEX_EP0		(0x00)
-#define S3C2410_UDC_INDEX_EP1		(0x01) // ??
-#define S3C2410_UDC_INDEX_EP2		(0x02) // ??
-#define S3C2410_UDC_INDEX_EP3		(0x03) // ??
-#define S3C2410_UDC_INDEX_EP4		(0x04) // ??
-
-#define S3C2410_UDC_ICSR1_CLRDT		(1<<6) // R/W
-#define S3C2410_UDC_ICSR1_SENTSTL	(1<<5) // R/W (clear only)
-#define S3C2410_UDC_ICSR1_SENDSTL	(1<<4) // R/W
-#define S3C2410_UDC_ICSR1_FFLUSH	(1<<3) // W   (set only)
-#define S3C2410_UDC_ICSR1_UNDRUN	(1<<2) // R/W (clear only)
-#define S3C2410_UDC_ICSR1_PKTRDY	(1<<0) // R/W (set only)
-
-#define S3C2410_UDC_ICSR2_AUTOSET	(1<<7) // R/W
-#define S3C2410_UDC_ICSR2_ISO		(1<<6) // R/W
-#define S3C2410_UDC_ICSR2_MODEIN	(1<<5) // R/W
-#define S3C2410_UDC_ICSR2_DMAIEN	(1<<4) // R/W
-
-#define S3C2410_UDC_OCSR1_CLRDT		(1<<7) // R/W
-#define S3C2410_UDC_OCSR1_SENTSTL	(1<<6) // R/W (clear only)
-#define S3C2410_UDC_OCSR1_SENDSTL	(1<<5) // R/W
-#define S3C2410_UDC_OCSR1_FFLUSH	(1<<4) // R/W
-#define S3C2410_UDC_OCSR1_DERROR	(1<<3) // R
-#define S3C2410_UDC_OCSR1_OVRRUN	(1<<2) // R/W (clear only)
-#define S3C2410_UDC_OCSR1_PKTRDY	(1<<0) // R/W (clear only)
-
-#define S3C2410_UDC_OCSR2_AUTOCLR	(1<<7) // R/W
-#define S3C2410_UDC_OCSR2_ISO		(1<<6) // R/W
-#define S3C2410_UDC_OCSR2_DMAIEN	(1<<5) // R/W
-
-#define S3C2410_UDC_EP0_CSR_OPKRDY	(1<<0)
-#define S3C2410_UDC_EP0_CSR_IPKRDY	(1<<1)
-#define S3C2410_UDC_EP0_CSR_SENTSTL	(1<<2)
-#define S3C2410_UDC_EP0_CSR_DE		(1<<3)
-#define S3C2410_UDC_EP0_CSR_SE		(1<<4)
-#define S3C2410_UDC_EP0_CSR_SENDSTL	(1<<5)
-#define S3C2410_UDC_EP0_CSR_SOPKTRDY	(1<<6)
-#define S3C2410_UDC_EP0_CSR_SSE	(1<<7)
-
-#define S3C2410_UDC_MAXP_8		(1<<0)
-#define S3C2410_UDC_MAXP_16		(1<<1)
-#define S3C2410_UDC_MAXP_32		(1<<2)
-#define S3C2410_UDC_MAXP_64		(1<<3)
-
+#define S3C2410_UDC_INDEX_EP1		(0x01)
+#define S3C2410_UDC_INDEX_EP2		(0x02)
+#define S3C2410_UDC_INDEX_EP3		(0x03)
+#define S3C2410_UDC_INDEX_EP4		(0x04)
+
+#define S3C2410_UDC_ICSR1_CLRDT		(1 << 6) /* R/W */
+#define S3C2410_UDC_ICSR1_SENTSTL	(1 << 5) /* R/W (clear only) */
+#define S3C2410_UDC_ICSR1_SENDSTL	(1 << 4) /* R/W */
+#define S3C2410_UDC_ICSR1_FFLUSH	(1 << 3) /* W   (set only) */
+#define S3C2410_UDC_ICSR1_UNDRUN	(1 << 2) /* R/W (clear only) */
+#define S3C2410_UDC_ICSR1_PKTRDY	(1 << 0) /* R/W (set only) */
+
+#define S3C2410_UDC_ICSR2_AUTOSET	(1 << 7) /* R/W */
+#define S3C2410_UDC_ICSR2_ISO		(1 << 6) /* R/W */
+#define S3C2410_UDC_ICSR2_MODEIN	(1 << 5) /* R/W */
+#define S3C2410_UDC_ICSR2_DMAIEN	(1 << 4) /* R/W */
+
+#define S3C2410_UDC_OCSR1_CLRDT		(1 << 7) /* R/W */
+#define S3C2410_UDC_OCSR1_SENTSTL	(1 << 6) /* R/W (clear only) */
+#define S3C2410_UDC_OCSR1_SENDSTL	(1 << 5) /* R/W */
+#define S3C2410_UDC_OCSR1_FFLUSH	(1 << 4) /* R/W */
+#define S3C2410_UDC_OCSR1_DERROR	(1 << 3) /* R   */
+#define S3C2410_UDC_OCSR1_OVRRUN	(1 << 2) /* R/W (clear only) */
+#define S3C2410_UDC_OCSR1_PKTRDY	(1 << 0) /* R/W (clear only) */
+
+#define S3C2410_UDC_OCSR2_AUTOCLR	(1 << 7) /* R/W */
+#define S3C2410_UDC_OCSR2_ISO		(1 << 6) /* R/W */
+#define S3C2410_UDC_OCSR2_DMAIEN	(1 << 5) /* R/W */
+
+#define S3C2410_UDC_EP0_CSR_OPKRDY	(1 << 0)
+#define S3C2410_UDC_EP0_CSR_IPKRDY	(1 << 1)
+#define S3C2410_UDC_EP0_CSR_SENTSTL	(1 << 2)
+#define S3C2410_UDC_EP0_CSR_DE		(1 << 3)
+#define S3C2410_UDC_EP0_CSR_SE		(1 << 4)
+#define S3C2410_UDC_EP0_CSR_SENDSTL	(1 << 5)
+#define S3C2410_UDC_EP0_CSR_SOPKTRDY	(1 << 6)
+#define S3C2410_UDC_EP0_CSR_SSE		(1 << 7)
+
+#define S3C2410_UDC_MAXP_8		(1 << 0)
+#define S3C2410_UDC_MAXP_16		(1 << 1)
+#define S3C2410_UDC_MAXP_32		(1 << 2)
+#define S3C2410_UDC_MAXP_64		(1 << 3)
 
 #endif
diff --git a/arch/arm/plat-s3c24xx/include/plat/udc.h b/arch/arm/plat-samsung/include/plat/udc.h
similarity index 95%
rename from arch/arm/plat-s3c24xx/include/plat/udc.h
rename to arch/arm/plat-samsung/include/plat/udc.h
index f638842..8c22d58 100644
--- a/arch/arm/plat-s3c24xx/include/plat/udc.h
+++ b/arch/arm/plat-samsung/include/plat/udc.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/udc.h
+/* arch/arm/plat-samsung/include/plat/udc.h
  *
  * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
  *
@@ -26,7 +26,7 @@ enum s3c2410_udc_cmd_e {
 
 struct s3c2410_udc_mach_info {
 	void	(*udc_command)(enum s3c2410_udc_cmd_e);
- 	void	(*vbus_draw)(unsigned int ma);
+	void	(*vbus_draw)(unsigned int ma);
 
 	unsigned int pullup_pin;
 	unsigned int pullup_pin_inverted;
-- 
1.7.1
