From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu,  8 Oct 2015 17:20:08 +0200
Subject: [PATCH 0/4] Add support for STM32 DMA
Message-ID: <1444317612-818-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 DMA controller.
This controller provides 8 channels dedicated to managing memory access
request from one or more peripherals.
Each stream can have up to 8 requests in total.

M'boumba Cedric Madianga (4):
  dt-bindings: Document the STM32 DMA bindings
  dmaengine: Add STM32 DMA driver
  ARM: dts: Add STM32 DMA support for STM32F429 MCU
  ARM: configs: Add STM32 DMA support in STM32 defconfig

 .../devicetree/bindings/dma/stm32-dma.txt          |   98 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |   31 +
 arch/arm/configs/stm32_defconfig                   |    2 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/stm32-dma.c                            | 1193 ++++++++++++++++++++
 6 files changed, 1337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt
 create mode 100644 drivers/dma/stm32-dma.c

-- 
1.9.1
