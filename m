From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 01 Feb 2013 18:21:52 +0530
Subject: [PATCH V2 0/4] Add generic DMA DT binding support
Message-ID: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Padmavathi Venna (4):
  DMA: PL330: Add xlate function
  DMA: PL330: Register the DMA controller with the generic DMA helpers
  ARM: dts: Add #dma-cells for generic dma binding support
  DMA: PL330: Modify pl330 filter based on new generic dma dt bindings.

 .../devicetree/bindings/dma/arm-pl330.txt          |   15 ++++--
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 ++
 drivers/dma/pl330.c                                |   56 ++++++++++++++++---
 3 files changed, 62 insertions(+), 13 deletions(-)

-- 
1.7.4.4
