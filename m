From: long.cheng@mediatek.com (Long Cheng)
Date: Thu, 16 Feb 2017 19:07:27 +0800
Subject: [PATCH 0/4] add uart DMA function
Message-ID: <1487243251-964-1-git-send-email-long.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DMA function.

Long Cheng (4):
  dt-bindings: dma: uart: add uart dma bindings
  dmaengine: mtk_uart_dma: add Mediatek uart DMA support
  serial: 8250-mtk: add uart DMA support
  arm: dts: mt2701: add uart APDMA to device tree

 .../devicetree/bindings/dma/mtk_uart_dma.txt       |   32 +
 arch/arm/boot/dts/mt2701-evb.dts                   |   22 +
 arch/arm/boot/dts/mt2701.dtsi                      |   29 +
 drivers/dma/Kconfig                                |    9 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/mtk_uart_dma.c                         |  955 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_mtk.c                 |  194 +++-
 7 files changed, 1241 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk_uart_dma.txt
 create mode 100644 drivers/dma/mtk_uart_dma.c

-- 
1.7.9.5
