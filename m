From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 28 Sep 2017 17:36:39 +0200
Subject: [PATCH v5 0/4] Add STM32 MDMA driver
Message-ID: <1506613003-28376-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 MDMA controller.
The Master Direct memory access (MDMA) provides high-speed data transfer
between memory and memory or between peripherals and memory.
Contrary to STM32 DMA, the STM32 MDMA controller supports hardware LLI and
uses a larger integrated FIFO (128 vs 16 bytes)
---
  Version history:
     v5:
         * Change 'platform_driver_probe' into
           'platform_driver_register' to manage defer mechanism
     v4:
         * Add safe getter/setter macros
         * forbid DMA preparation in cyclic mode yet
         * Optimize burst and memory width for memcpy
         * replace of_property_xx by device_property_xx
     v3:
         * Update header template
         * Unsigned expression compared with zero
         * Rework stm32_mdma_get_max_width
         * moved to src/dst case where they are used in set_xfer
         * Change of_property_* with device_property_*
         * Add dev_warn whether default value is used
         * Indentation
         * Add MODULE_*
     v2:
         * change compatible into st,stm32h7-mdma to be more SoC specific
         * Add MDMA support in DT for H7
         * Add MDMA support in STM32 defconfig
---
Pierre-Yves MORDRET (4):
  dt-bindings: Document the STM32 MDMA bindings
  dmaengine: Add STM32 MDMA driver
  ARM: dts: stm32: Add MDMA support for STM32H743 SoC
  ARM: configs: stm32: Add MDMA support in STM32 defconfig

 .../devicetree/bindings/dma/stm32-mdma.txt         |   94 ++
 arch/arm/boot/dts/stm32h743.dtsi                   |   10 +
 arch/arm/configs/stm32_defconfig                   |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/stm32-mdma.c                           | 1666 ++++++++++++++++++++
 6 files changed, 1784 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt
 create mode 100644 drivers/dma/stm32-mdma.c

-- 
2.7.4
