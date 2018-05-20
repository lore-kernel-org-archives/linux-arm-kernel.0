From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 21 May 2018 01:01:46 +0800
Subject: [PATCH v1 0/7] add external interrupt support to MT7622 pinctrl
Message-ID: <cover.1526835466.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The series is to add external interrupt support to MT7622 pinctrl.

Before we can freely do that in pinctrl-mt7622.c with patch 3, a refactor
work has to be done with patch 2 to split EINT-related code from a
specific driver and then allows pintrl-mt7622.c to reuse it.

patch 1, 3, 7: add EINT support to MT7622 pinctrl.
patch 2, 6: make EINT-related become a generic way for all MediaTek
	    pinctrl.
patch 4, 5: eliminate unnecessary code in existent EINT-related ones after
	    refactor work was done.

Sean Wang (7):
  dt-bindings: pinctrl: add external interrupt support to MT7622 pinctrl
  pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl
    can fit
  pinctrl: mediatek: add EINT support to MT7622 SoC
  pinctrl: mediatek: use generic EINT register maps for each SoC
  pinctrl: mediatek: remove unused fields in struct mtk_eint_hw
  MAINTAINERS: update entry for PIN CONTROLLER - MEDIATEK
  arm64: dts: mt7622: add EINT support to pinctrl

 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt |  10 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   8 +-
 drivers/pinctrl/mediatek/Kconfig                   |   6 +
 drivers/pinctrl/mediatek/Makefile                  |   1 +
 drivers/pinctrl/mediatek/mtk-eint.c                | 492 +++++++++++++++++
 drivers/pinctrl/mediatek/mtk-eint.h                | 106 ++++
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          | 143 +++++
 drivers/pinctrl/mediatek/pinctrl-mt8127.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt8135.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c          |  25 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      | 608 ++++-----------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |  13 +-
 16 files changed, 901 insertions(+), 614 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.c
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.h

-- 
2.7.4
