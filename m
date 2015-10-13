From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 13 Oct 2015 17:37:54 +0800
Subject: [PATCH 0/4] Add tune support of Mediatek MMC driver 
Message-ID: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for eMMC hardware reset
Add pinctrl of data strobe pin for HS400 mode
Modify eMMC driving settings
Add 400mhz source clock for HS400 mode
Add eMMC HS200/HS400 mode support
Add SD SDR50/SDR104 mode support
Add implement of tune funtion with CMD19/CMD21

Chaotian Jing (4):
  mmc: core: Add DT bindings for eMMC hardware reset support
  mmc: dt-bindings: update Mediatek MMC bindings
  mmc: mediatek: Add tune support
  arm64: dts: mediatek:: Add HS200/HS400/SDR50/SDR104 support

 Documentation/devicetree/bindings/mmc/mmc.txt    |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  12 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  21 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   5 +-
 drivers/mmc/core/host.c                          |   2 +
 drivers/mmc/host/mtk-sd.c                        | 359 +++++++++++++++++++++--
 6 files changed, 364 insertions(+), 36 deletions(-)

-- 
1.8.1.1.dirty
