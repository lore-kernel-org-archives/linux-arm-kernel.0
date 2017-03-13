From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 13 Mar 2017 15:15:56 +0100
Subject: [PATCH 0/5] Add STM32 DMAMUX support
Message-ID: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 DMA multiplexer.
It allows to map any peripheral DMA request to any channel of the product
DMAs.
This IP has been introduced with STM32H7 SoC.

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 DMAMUX bindings
  dmaengine: Add STM32 DMAMUX driver
  dt-bindings: stm32-dma: Add property to handle STM32 DMAMUX
  dmaengine: stm32-dma: Add support for STM32 DMAMUX
  ARM: configs: stm32: Add DMAMUX support in STM32 defconfig

 .../devicetree/bindings/dma/stm32-dma.txt          |   3 +
 .../devicetree/bindings/dma/stm32-dmamux.txt       |  57 +++++
 arch/arm/configs/stm32_defconfig                   |   1 +
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/stm32-dma.c                            |  13 +-
 drivers/dma/stm32-dmamux.c                         | 231 +++++++++++++++++++++
 7 files changed, 312 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
 create mode 100644 drivers/dma/stm32-dmamux.c

-- 
1.9.1
