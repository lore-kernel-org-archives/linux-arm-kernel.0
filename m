From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 19 May 2015 14:36:44 +0800
Subject: [PATCH v4 0/7] Add Mediatek MMC driver 
Message-ID: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables MMC support on the MT8135/MT8173 platform.
MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.

Changes base on Ulf and Sascha's comments
Move the msdc_ungate_clock to ->probe()
Add ops->card_busy for SD3.0 voltage switch check
Disable HCLK at runtime pm suspend
Save/restore registers at runtime pm suspend/resume
Make bus clock free running to avoid ambiguity when the
MMC core layer want to enable bus clock
Modify MSDC register range from 0x108 to 0x1000


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
 arch/arm/boot/dts/mt8135-evbp1.dts               |  139 ++
 arch/arm/boot/dts/mt8135.dtsi                    |   26 +
 arch/arm/configs/multi_v7_defconfig              |    1 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  115 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   43 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1513 ++++++++++++++++++++++
 10 files changed, 1879 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c

-- 
1.8.1.1.dirty
