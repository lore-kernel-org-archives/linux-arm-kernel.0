From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Thu, 22 Mar 2018 10:58:38 +0800
Subject: [PATCH v4 0/5] PINCTRL: Mediatek pinctrl driver for mt2712 
Message-ID: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes five patches:
1.Add mt2712 pintcrl head file.
2.Add mt2712 pinctrl device node.
3.Add mt2712 pinctrl driver.
4.Support bias-disable of generic and special pins simultaneously.
5.fix check warnings.

Changes in patch v4:
1)fix check warnings for mt2712.
2)add fix check warnings patch for other ICs.

Changes in patch v3:
1)Use SPDX identifiers for all new files.
2)Use right data for Copyright and Author.
3)Correct some spelling mistake.
4)Reusing original logic and change solution to support bias-disable of generic and special pins simultaneously.
5)Add some comments for the speical path of special pins bias-disable.

Changes in patch v2:
1)Separate patch4 for supporting bias-disable of generic and special pins.
2)GPIO16~17 direction setting is changed as generic pins in mt2712 E2,
  So remove GPIO16~17 special direction setting and remove apmixedsys node in pinctrl device node.
3)Add pinmux define in "mt2712-pinfunc.h" and "pinctrl-mtk-mt2712.h" for mt2712 E2 design.


Zhiyong Tao (5):
  arm64: dts: mt2712: add pintcrl file
  arm64: dts: mt2712: add pintcrl device node.
  pinctrl: add mt2712 pinctrl driver
  pintcrl: support bias-disable of generic and special pins
    simultaneously
  pinctrl: fix check warnings.

 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 1123 ++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   18 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  634 +++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    8 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h |  840 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h | 1757 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6397.h |  123 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8127.h |  429 ++----
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h |  609 +++------
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h |  405 ++----
 12 files changed, 4348 insertions(+), 1606 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h

--
2.6.4
