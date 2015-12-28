From: biao.huang@mediatek.com (Biao Huang)
Date: Mon, 28 Dec 2015 15:09:01 +0800
Subject: [PATCH v3 0/5] pinctrl: mediatek: add pinctrl/GPIO/EINT driver for
 mt2701
Message-ID: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change in v3:
1. convert to arch_initcall.
2. set direction to input when do input-enable/disable and input-schmitt-enable/disable properties.

Change in v2:
1. add special pinmux setting for some pins.
2. fix mt2701 direction control issue.
3. resort dt-bindings.

Biao Huang (4):
  dt-bindings: mediatek: Modify pinctrl bindings for mt2701
  pinctrl: dt bindings: Add pinfunc header file for mt2701
  pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver for mt2701
  arm: dts: Add pinctrl/GPIO/EINT node for mt2701

Erin Lo (1):
  ARM: mediatek: Add MT2701 config options for mediatek SoCs.

 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    9 +-
 arch/arm/boot/dts/mt2701-pinfunc.h                 |  735 +++++++
 arch/arm/boot/dts/mt2701.dtsi                      |   19 +
 arch/arm/mach-mediatek/Kconfig                     |    4 +
 drivers/pinctrl/mediatek/Kconfig                   |    6 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |  586 +++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   16 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |   12 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h      | 2323 ++++++++++++++++++++
 10 files changed, 3706 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt2701-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2701.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h

-- 
1.7.9.5 
