From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 9 Feb 2018 01:58:46 +0800
Subject: [PATCH v4 0/5] add support for Mediatek High-Speed DMA controller on
 MT7622 and MT7623 SoC
Message-ID: <cover.1518110810.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v3:
- enhance dt-binding documents based on Rob's comments
- make consistent among all comments
- perfer ordering declarations longest to shortest
- fix warning reported from kbuild test robot
- add patch 4 and 5 to keep Fengguang and Julia's effort

Changes since v2:
- remove extra tasklets and refactor driver for letting descriptors being processed ASAP.
- add more comments stating the relevant logic
- remove unused macro and variables
- change to use the disclaimer with SPDX identifier
- add mt7622 support
- refine hardware initialization sequence
- add tx_status support for DMA_RESIDUE_GRANULARITY_SEGMENT
- refine remove handler with killing vc's tasklet

Changes since v1:
- fix typo in the commit message.
- delete status shown in the dt-binding example.

This patchset introduces support for MediaTek High-Speed DMA controller
(MTK-HSDMA) Currently, the driver is already tested successfully with
dmatest module on MT7622 and MT7623 SoC. 

MTK-HSDMA on MT7622/23 SoC has a single ring which is dedicated for
doing memory-to-memory transfer through ring-based descriptor management.
Even though there is only a single ring available inside HSDMA, the
driver is being extended to the support for multiple virtual channels
processing simultaneously by means of DMA_VIRTUAL_CHANNELS.

Sean Wang (3):
  dt-bindings: dmaengine: Add MediaTek High-Speed DMA controller
    bindings
  dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622
    and MT7623 SoC
  dmaengine: mediatek: update MAINTAINERS entry with MediaTek DMA driver

kbuild test robot (1):
  dmaengine: mediatek: mtk_hsdma_find_active_desc() can be static

 .../devicetree/bindings/dma/mtk-hsdma.txt          |   33 +
 MAINTAINERS                                        |    9 +
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/mediatek/Kconfig                       |   13 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-hsdma.c                   | 1044 ++++++++++++++++++++
 7 files changed, 1103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt
 create mode 100644 drivers/dma/mediatek/Kconfig
 create mode 100644 drivers/dma/mediatek/Makefile
 create mode 100644 drivers/dma/mediatek/mtk-hsdma.c

-- 
2.7.4
