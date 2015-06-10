From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 10 Jun 2015 10:24:41 +0800
Subject: [PATCH v5 0/7] Add Mediatek MMC driver 
Message-ID: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables MMC support on the MT8135/MT8173 platform.
MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.

Changes base on Ulf and Sascha's comments
Make hclk mandatory
Disable source clock and HCLK in runtime pm suspend
Fix dma_map_sg issue
Seclect pinctrl only when setting the signal voltage

Chaotian Jing (3):
  mmc: dt-bindings: add Mediatek MMC bindings
  mmc: mediatek: Add Mediatek MMC driver
  mmc: mediatek: Add PM support for MMC driver

Eddie Huang (2):
  arm64: dts: mediatek: Add MT8173 MMC dts
  arm64: mediatek: Add Mediatek MMC support in defconfig

Yingjoe Chen (2):
  ARM: mediatek: dts: Add emmc support to mt8135
  ARM: multi_v7_defconfig: Enable Mediatek MMC support multi-v7

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   32 +
 arch/arm/boot/dts/mt8135-evbp1.dts               |  158 +++
 arch/arm/boot/dts/mt8135.dtsi                    |   55 +
 arch/arm/configs/multi_v7_defconfig              |    1 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  126 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   45 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1464 ++++++++++++++++++++++
 include/linux/mmc/core.h                         |    1 +
 11 files changed, 1891 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c

-- 
1.8.1.1.dirty
