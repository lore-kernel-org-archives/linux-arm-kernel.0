From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 14 Oct 2015 11:23:30 +0800
Subject: [PATCH 0/5] mt8173 spi multiple devices support 
Message-ID: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are based on 4.3-rc1 and provide 5 patches to support
mt8173 spi multiple devices.

Change in this series:
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
  arm64: dts: spi bus dts support multiple devices

 .../devicetree/bindings/spi/spi-mt65xx.txt         |   8 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   3 +-
 drivers/spi/spi-mt65xx.c                           | 129 +++++++++++++--------
 3 files changed, 91 insertions(+), 49 deletions(-)
 mode change 100755 => 100644 drivers/spi/spi-mt65xx.c

--
1.8.1.1.dirty
