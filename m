From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 19 Jul 2018 01:37:05 +0530
Subject: [PATCH 0/4] Add Actions Semi Owl family S900 DMA Controller support
Message-ID: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds DMA controller support for Actions Semi Owl family
S900 SoC. This driver has been structured in a way such that there will be only
one controller driver for the whole Owl family series (S500, S700 and
S900 SoCs).

There are 12 physical channels and 46 logical channels supported by the
DMA controller.

The DMA controller also supports 4 software configurable interrupt lines for
the priority based DMA usecase. But the DMA driver supports only 1 interrupt
for simplification. By default, the driver uses Linked list mode for all
transfers. Right now only MEMCPY support has been added and the rest
(SLAVE, CYCLIC) will be added in upcoming patches.

The driver has been tested using dmatest utility on the Bubblegum-96
board.

The DTS patches in this series depends on the pinctrl DTS patches
submitted [1], which is yet to be merged by the platform maintainer
Andreas. Since the DMA driver goes through DMA tree and the relevant
DTS patches goes through ARM-SoC tree, Andreas will pick it up once
it has been reviewed.

For the reference, I have queued up all reviewed dts patches so far
in my repo [2] from which Andreas is picking them for 4.19.

Thanks,
Mani

[1] https://patchwork.kernel.org/patch/10322937/
[2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next

Manivannan Sadhasivam (4):
  dt-bindings: dma: Add binding for Actions Semi Owl SoCs
  arm64: dts: actions: Add Actions Semi S900 DMA Controller
  dma: Add Actions Semi Owl family S900 DMA driver
  MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver

 .../devicetree/bindings/dma/owl-dma.txt       |   46 +
 MAINTAINERS                                   |    2 +
 arch/arm64/boot/dts/actions/s900.dtsi         |   13 +
 drivers/dma/Kconfig                           |    8 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/owl-dma.c                         | 1021 +++++++++++++++++
 6 files changed, 1091 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 drivers/dma/owl-dma.c

-- 
2.17.1
