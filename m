From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 11 Feb 2013 14:08:20 +0530
Subject: [PATCH V4 0/5] Add generic DMA DT binding support
Message-ID: <1360571905-15285-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since V3:
	- Make dma-cells property optional as suggested by Rob Herring
	- Add dma-requests and dma-channels properties to DMA controller
	  as suggested by Arnd for future-proof
	- Add Acked-by for some of the patches

Changes since V2:
        - Add new filter function for DT case as suggested by Arnd
        - Add xlate as static function
        - Use newly added filter function in xlate.
        - Add Acked-by for some of the patches

Changes since V1:
        - Address the review comments by Arnd Bergmann as below
        - Wording of the properties.
        - Pass pdmac as third parameter to of_dma_controller_register
        - Filter the dma channel based on channel number and dma_device

This patch set adds support for generic dma device tree bindings for
Samsung platforms and is dependent on the following patches from
Vinod Koul next branch
1)of: Add generic device tree DMA helpers
2)dmaengine: add helper function to request a slave DMA channel

This patch set is made based Mark Brown next branch

Padmavathi Venna (5):
  DMA: PL330: Add new pl330 filter for DT case.
  DMA: PL330: Add xlate function
  DMA: PL330: Register the DMA controller with the generic DMA helpers
  ARM: dts: pl330: Add #dma-cells for generic dma binding support
  ARM: SAMSUNG: dma: Remove unnecessary code

 .../devicetree/bindings/dma/arm-pl330.txt          |   21 +++++--
 arch/arm/boot/dts/exynos5250.dtsi                  |   12 ++++
 arch/arm/mach-s3c24xx/include/mach/dma.h           |    1 -
 arch/arm/mach-s3c64xx/include/mach/dma.h           |    1 -
 arch/arm/plat-samsung/dma-ops.c                    |   10 +---
 arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 -
 arch/arm/plat-samsung/include/plat/dma-pl330.h     |    1 -
 drivers/dma/pl330.c                                |   64 +++++++++++++++----
 8 files changed, 79 insertions(+), 32 deletions(-)

-- 
1.7.4.4
