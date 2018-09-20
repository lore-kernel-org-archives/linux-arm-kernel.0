From: long.cheng@mediatek.com (Long Cheng)
Date: Thu, 20 Sep 2018 14:41:09 +0800
Subject: [PATCH 0/4] add uart DMA function 
Message-ID: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
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

 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   32 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   50 +
 drivers/dma/8250_mtk_dma.c                         | 1049 ++++++++++++++++++++
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/tty/serial/8250/8250_mtk.c                 |  211 +++-
 6 files changed, 1353 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 drivers/dma/8250_mtk_dma.c

-- 
1.7.9.5
