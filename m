From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 15:44:13 +0900
Subject: [PATCH V3 00/13] To use DMA generic APIs for Samsung DMA
Message-ID: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following is diagram of this changes

+---------------------------------------------------------------------+
| Each drivers which uses DMA                                         |
+---------------------------------------------------------------------+
| S3C DMA API (such as s3c2410_dma_xxxx)                              |
+-------------------------------+-------------------------------------+
| DMA driver for S3C24XX        | S3C PL330 DMA API driver            |
| PL080 DMA driver for S3C64XX  | (arch/arm/plat-samsung/s3c-pl330.c) |
|                               +-------------------------------------+
| (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver              |
| (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c)           |
+-------------------------------+-------------------------------------+
                               ||
               (removing S3C DMA API for PL330)
                               ||
                               \/
+---------------------------------------------------------------------+
| Each drivers which uses DMA                                         |
+-------------------------------+-------------------------------------+
| S3C DMA API(s3c2410_dma_xxx)  | DMA generic API for PL330           |
+-------------------------------+-------------------------------------+
| DMA driver for S3C24XX        | PL330 DMA API driver                |
| PL080 DMA driver for S3C64XX  | (drivers/dma/pl330.c)               |
|                               +-------------------------------------+
| (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver              |
| (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c)           |
+-------------------------------+-------------------------------------+

[PATCH V3 01/13] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH V3 02/13] DMA: PL330: Update PL330 DMA API driver
[PATCH V3 03/13] DMA: PL330: Add DMA capabilities
[PATCH V3 04/13] ARM: SAMSUNG: Update to use PL330-DMA driver
[PATCH V3 05/13] ARM: SAMSUNG: Add common DMA operations
[PATCH V3 06/13] ARM: EXYNOS4: Use generic DMA PL330 driver
[PATCH V3 07/13] ARM: S5PV210: Use generic DMA PL330 driver
[PATCH V3 08/13] ARM: S5PC100: Use generic DMA PL330 driver
[PATCH V3 09/13] ARM: S5P64X0: Use generic DMA PL330 driver
[PATCH V3 10/13] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
[PATCH V3 11/13] spi/s3c64xx: Add support DMA engine API
[PATCH V3 12/13] ASoC: Samsung: Update DMA interface
[PATCH V3 13/13] ARM: SAMSUNG: Remove Samsung specific enum type for dma direction
