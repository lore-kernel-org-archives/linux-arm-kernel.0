From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Mon, 18 May 2015 23:11:11 -0700
Subject: [PATCH v2 0/11] Mediatek pinctrl driver optimize and add Mediatek SoC
 Pinctrl/GPIO/EINT driver for mt6397/mt8127.
Message-ID: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to these patches haven't sent to ML, just resend them.

Changes in v2:
  - Break mfd relate change out into a sparate patch.
  - Rearrange order of patches.

Hongzhou Yang (7):
  dt-bindings: mediatek: Modify pinctrl bindings for mt6397.
  pinctrl: dt bindings: mt6397: Add pinfunc header file for mt6397.
  pinctrl: mediatek: add ies/smt control to common code.
  pinctrl: mediatek: Add Pinctrl/GPIO driver for mt6397.
  mfd: mediatek: Add GPIO sub module support into mfd.
  arm64: dts: mt8173-evb: Add pinctrl/GPIO node for mt6397.
  ARM: dts: mt8135-evbp1: Add pinctrl/GPIO node for mt6397.

Yingjoe Chen (4):
  pinctrl: mediatek: data struct optimize and remove unused member
  pinctrl: mediatek: add mtk_pctrl_spec_pull_set_samereg common code
  pinctrl: mediatek: add pinctrl/GPIO/EINT driver for mt8127
  ARM: dts: mt8127: add pinctrl/GPIO/EINT node for mt8127

 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    9 +-
 arch/arm/boot/dts/mt8127-pinfunc.h                 |  742 +++++++++++
 arch/arm/boot/dts/mt8127.dtsi                      |   22 +
 arch/arm/boot/dts/mt8135-evbp1.dts                 |    9 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |    8 +
 drivers/mfd/mt6397-core.c                          |    3 +
 drivers/pinctrl/mediatek/Kconfig                   |   12 +
 drivers/pinctrl/mediatek/Makefile                  |    2 +
 drivers/pinctrl/mediatek/pinctrl-mt6397.c          |   78 ++
 drivers/pinctrl/mediatek/pinctrl-mt8127.c          |  359 ++++++
 drivers/pinctrl/mediatek/pinctrl-mt8135.c          |   12 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c          |  369 +++---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  155 ++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |   75 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6397.h      |  424 +++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8127.h      | 1318 ++++++++++++++++++++
 include/dt-bindings/pinctrl/mt6397-pinfunc.h       |  256 ++++
 17 files changed, 3595 insertions(+), 258 deletions(-)  create mode 100644 arch/arm/boot/dts/mt8127-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6397.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8127.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6397.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8127.h
 create mode 100644 include/dt-bindings/pinctrl/mt6397-pinfunc.h

--
1.7.9.5
