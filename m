From: shun-chih.yu@mediatek.com (shun-chih.yu at mediatek.com)
Date: Wed, 17 Oct 2018 17:36:57 +0800
Subject: [PATCH v2] add support for Mediatek Command-Queue DMA controller on
 MT6765 SoC
Message-ID: <1539769019-32107-1-git-send-email-shun-chih.yu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changes since v1:
- remove unused macros, typos
- leverage ASYNC_TX_ENABLE_CHANNEL_SWITCH to maintain DMA descriptor list


This patchset introduces support for MediaTek Command-Queue DMA controller.

MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated to memory-to-memory transfer through queue-based descriptor management.

There are only 3 physical channels inside CQDMA, while the driver is extended to support 32 virtual channels for multiple dma users to issue dma requests onto the CQDMA simultaneously.


Shun-Chih Yu (2):
  dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
    bindings
  dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
    MT6765 SoC

 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 +
 drivers/dma/mediatek/Kconfig                       |   13 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-cqdma.c                   |  943 ++++++++++++++++++++
 4 files changed, 988 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
