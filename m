From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 27 Jul 2011 14:31:22 +0900
Subject: [PATCH V5 00/15] To use DMA generic APIs for Samsung DMA
Message-ID: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support DMA generic APIs for Samsung DMA.

The changes from V4 are following:
- Change DMA cyclic capability operation on '04 patch'
	- Remove cyclic_task
	- Initialize 'cyclic' variable on channel request.
- Change pl330 data structure on '02, 07, 08, 09, 10 patches'
	- Move 'fifo_addr' and 'burst_sz' variables from 'struct dma_pl330_peri'
	  to 'struct dma_pl330_chan'
- Change some names on '02, 05 patch'
	- Change DMADEV_PL330 configuration to SAMSUNG_DMA_PL330
	- Add comment for 'burst_sz' variable
- Consider 'xxx_maxburst' on '03, 06 patch'
- Modify pl330_filter() function on '06 patch'
- Merge DMA control code on SPI driver on '13 patch'

[PATCH V5 01/15] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH V5 02/15] DMA: PL330: Update PL330 DMA API driver
[PATCH V5 03/15] DMA: PL330: Support DMA_SLAVE_CONFIG command
[PATCH V5 04/15] DMA: PL330: Add DMA_CYCLIC capability
[PATCH V5 05/15] ARM: SAMSUNG: Update to use PL330-DMA driver
[PATCH V5 06/15] ARM: SAMSUNG: Add common DMA operations
[PATCH V5 07/15] ARM: EXYNOS4: Use generic DMA PL330 driver
[PATCH V5 08/15] ARM: S5PV210: Use generic DMA PL330 driver
[PATCH V5 09/15] ARM: S5PC100: Use generic DMA PL330 driver
[PATCH V5 10/15] ARM: S5P64X0: Use generic DMA PL330 driver
[PATCH V5 11/15] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
[PATCH V5 12/15] spi/s3c64xx: Add support DMA engine API
[PATCH V5 13/15] spi/s3c64xx: Merge dma control code
[PATCH V5 14/15] ASoC: Samsung: Update DMA interface
[PATCH V5 15/15] ARM: SAMSUNG: Remove Samsung specific enum type for dma direction
