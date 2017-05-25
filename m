From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 25 May 2017 15:12:47 +0800
Subject: [PATCH v2 0/2] dmaengine: mtk-hsdma: add support for Mediatek
 High-Speed DMA controller on MT7623 SoC
Message-ID: <cover.1495695814.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v1:
- fix typo in the commit message.
- delete status shown in the dt-binding example.

This patchset introduces support for Mediatek High-Speed DMA controller
(MTK-HSDMA) Currently, the driver is already tested successfully with
dmatest module on MT7623 SoC. 

MTK-HSDMA on MT7623 SoC has the single channel which is dedicated to
memory-to-memory transfer through ring-based descriptor management.
Even though there is only one physical channel available inside HSDMA,
the driver is extended to the support for multiple virtual channels
processing simultaneously in round-round way by means of the feature
DMA_VIRTUAL_CHANNELS.

Sean Wang (2):
  dt-bindings: dmaengine: Add Mediatek High-Speed DMA controller
    bindings
  dmaengine: mtk-hsdma: Add Mediatek High-Speed DMA controller on MT7623
    SoC

 .../devicetree/bindings/dma/mtk-hsdma.txt          |  29 +
 drivers/dma/Kconfig                                |  14 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/mtk-hsdma.c                            | 890 +++++++++++++++++++++
 4 files changed, 934 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt
 create mode 100644 drivers/dma/mtk-hsdma.c

-- 
2.7.4
