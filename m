From: shun-chih.yu@mediatek.com (shun-chih.yu at mediatek.com)
Date: Thu, 18 Oct 2018 15:49:09 +0800
Subject: [PATCH v3] add support for Mediatek Command-Queue DMA controller on
 MT6765 SoC
Message-ID: <1539848951-14798-1-git-send-email-shun-chih.yu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changes since v2:
- fix build warning for kernel with DMA address in 32-bit

Changes since v1:
- remove unused macros, typos
- leverage ASYNC_TX_ENABLE_CHANNEL_SWITCH to maintain DMA descriptor list

Shun-Chih Yu (2):
  dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
    bindings
  dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
    MT6765 SoC

 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 +
 drivers/dma/mediatek/Kconfig                       |   13 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-cqdma.c                   |  951 ++++++++++++++++++++
 4 files changed, 996 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
