From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 26 Oct 2015 16:09:40 +0800
Subject: [PATCH v2 0/5] mt8173 spi multiple devices support 
Message-ID: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are based on 4.3-rc1 and provide 5 patches to support
mt8173 spi multiple devices.

Change in v2:
1. add mt8173 board name on patch 5/5 subject.
2. fix this series merge conflict.

Change in v1:
1. update document to add cs-gpio;
2. remove mtk_spi_config function;
3. move controller_data to master->setup;
4. add mt8173 spi multiple devices support;
5. update dts to add cs-gpio and modify cs pin to gpio function.

Leilk Liu (5):
  dt-binding: spi: Mediatek: Update document devicetree bindings to
    support multiple devices
  spi: mediatek: remove mtk_spi_config
  spi: mediatek: handle controller_data in mtk_spi_setup
  spi: mediatek: mt8173 spi multiple devices support
  arm64: dts: mt8173: spi bus dts support multiple devices

 .../devicetree/bindings/spi/spi-mt65xx.txt         |   9 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   3 +-
 drivers/spi/spi-mt65xx.c                           | 129 +++++++++++++--------
 3 files changed, 91 insertions(+), 50 deletions(-)

--
1.8.1.1.dirty
