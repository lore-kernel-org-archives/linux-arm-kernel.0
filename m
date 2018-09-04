From: shun-chih.yu@mediatek.com (shun-chih.yu at mediatek.com)
Date: Tue, 4 Sep 2018 16:43:44 +0800
Subject: [PATCH] add support for Mediatek Command-Queue DMA controller on
 MT6765 SoC
Message-ID: <1536050626-21927-1-git-send-email-shun-chih.yu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patchset introduces support for MediaTek Command-Queue DMA controller.

MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated to memory-to-memory transfer through queue-based descriptor management.

There are only 3 physical channels inside CQDMA, while the driver is extended to support 32 virtual channels for multiple dma users to issue dma requests onto the CQDMA simultaneously.

Shun-Chih Yu (2):
  dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
    bindings
  dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
    MT6765 SoC

 .../devicetree/bindings/dma/mtk-cqdma.txt          |  31 +
 drivers/dma/mediatek/Kconfig                       |  12 +
 drivers/dma/mediatek/Makefile                      |   1 +
 drivers/dma/mediatek/mtk-cqdma.c                   | 952 +++++++++++++++++++++
 4 files changed, 996 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
