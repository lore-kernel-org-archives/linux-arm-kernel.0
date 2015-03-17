From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 17 Mar 2015 11:13:50 +0800
Subject: [PATCH v2 0/5] Add Mediatek MMC driver 
Message-ID: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables MMC support on the MT8135/MT8173 platform.
MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.

Changes base on Ulf's comment in HKG15:
Remove useless #include and make it sorted
Remove BIT(x), only use (1 << x)
Remove useless structure
Move all defines to begin of the code
Remove useless defines
Move PM/Runtime PM as an extra patch
Remove "BUG()" in the code
Take place core-power, io-power with mmc_regulator APIs
Handle MMC_POWER_ON in set_ios
Remove msdc_of_parse, call these methods in probe directly

Chaotian Jing (3):
  mmc: dt-bindings: add Mediatek MMC bindings
  mmc: mediatek: Add Mediatek MMC driver
  mmc: mediatek: Add PM support for MMC driver

Eddie Huang (2):
  arm64: mediatek: Add Mediatek MMC support in defconfig
  arm64: dts: mediatek: Add MT8173 MMC dts

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   33 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  115 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   19 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1504 ++++++++++++++++++++++
 7 files changed, 1680 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c


Chaotian Jing (3):
  mmc: dt-bindings: add Mediatek MMC bindings
  mmc: mediatek: Add Mediatek MMC driver
  mmc: mediatek: Add PM support for MMC driver

Eddie Huang (2):
  arm64: mediatek: Add Mediatek MMC support in defconfig
  arm64: dts: mediatek: Add MT8173 MMC dts

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   33 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  115 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   19 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1504 ++++++++++++++++++++++
 7 files changed, 1680 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c
