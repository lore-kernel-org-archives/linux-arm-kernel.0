From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 28 Apr 2015 17:48:38 +0800
Subject: [PATCH v3 0/7] Add Mediatek MMC driver
Message-ID: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables MMC support on the MT8135/MT8173 platform.
MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.

Changes base on Ulf and Sascha's comments
Remove useless macros and use hex value
Remove setting for ocr_avail
Modify the flow of "set clock to 0"
Fix the race condition of cancel_delayed_work
Replace some dev_err to WARN_ON()
Remove useless "ACCESS_ONCE"	
Use clk_disable_unprepare() to instead of clk_disable() and clk_unprepare()
Use clk_prepare_enable() to instead  of clk_prepare() and clk_enable()
Fix the judgment of 1.8V IO
Fix the judgment of DDR mode
Make the enable/disable of vqmmc balanced
Fix runtime pm flow by Ulf and Sascha's comments


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

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   33 +
 arch/arm/boot/dts/mt8135-evbp1.dts               |  141 +++
 arch/arm/boot/dts/mt8135.dtsi                    |   26 +
 arch/arm/configs/multi_v7_defconfig              |    1 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  115 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   22 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1464 ++++++++++++++++++++++
 10 files changed, 1811 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c
