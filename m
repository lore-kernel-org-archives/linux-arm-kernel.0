From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  8 Jul 2015 17:11:21 +0100
Subject: [PATCH 0/7] Add support for FDMA DMA controller found on STi chipsets
Message-ID: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the Flexible Direct Memory Access (FDMA) core
found on STi chipsets from STMicroelectronics. The FDMA is a slim core CPU
with a dedicated firmware. It is a general purpose DMA controller supporting
16 independent channels and data can be moved from memory to memory or between
memory and paced latency critical real time targets.

To increase the number of peripheral request, support is also added for the
FDMA crossbar hardware, which can be used to multiplex up to 96 peripheral
requests, to the 3 fdma engines.

regards,

Peter.

Peter Griffin (7):
  dmaengine: st_fdma: Add STMicroelectronics FDMA DT binding
    documentation
  dmaengine: st_fdma: Add STMicroelectronics FDMA xbar DT binding
    documentation
  dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support
  dmaengine: st_fdma: Add xbar support
  ARM: STi: DT: STiH407: Add FDMA driver and xbar driver dt nodes.
  MAINTAINERS: Add FDMA driver files to STi section.
  ARM: multi_v7_defconfig: Enable STi FDMA driver

 Documentation/devicetree/bindings/dma/st_fdma.txt |  100 ++
 MAINTAINERS                                       |    2 +
 arch/arm/boot/dts/stih407-family.dtsi             |   59 +
 arch/arm/configs/multi_v7_defconfig               |    2 +
 drivers/dma/Kconfig                               |   26 +
 drivers/dma/Makefile                              |    2 +
 drivers/dma/st_fdma.c                             | 1203 +++++++++++++++++++++
 drivers/dma/st_fdma.h                             |  266 +++++
 drivers/dma/st_fdma_xbar.c                        |  149 +++
 include/linux/platform_data/dma-st_fdma.h         |   70 ++
 10 files changed, 1879 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt
 create mode 100644 drivers/dma/st_fdma.c
 create mode 100644 drivers/dma/st_fdma.h
 create mode 100644 drivers/dma/st_fdma_xbar.c
 create mode 100644 include/linux/platform_data/dma-st_fdma.h

-- 
1.9.1
