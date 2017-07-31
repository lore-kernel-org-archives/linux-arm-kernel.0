From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Jul 2017 15:21:05 +0900
Subject: [PATCH 0/6] pinctrl: uniphier: UniPhier pinctrl updates for v4.14
Message-ID: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes:
  - Clean up redundant pin data
  - Add simple suspend / resume support
  - Add a driver for a new SoC



Masahiro Yamada (6):
  pinctrl: uniphier: remove unneeded EXPORT_SYMBOL_GPL()
  pinctrl: uniphier: fix pin_config_get() for input-enable
  pinctrl: uniphier: clean up GPIO port muxing
  pinctrl: uniphier: omit redundant input enable bit information
  pinctrl: uniphier: add suspend / resume support
  pinctrl: uniphier: add UniPhier PXs3 pinctrl driver

 drivers/pinctrl/uniphier/Kconfig                 |   4 +
 drivers/pinctrl/uniphier/Makefile                |   1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 277 +++++--
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 660 ++++-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 709 +++++-----------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 273 +------
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 386 +--------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 451 +----------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 458 +----------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 386 +--------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 989 +++++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 273 +------
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  40 +-
 13 files changed, 1809 insertions(+), 3098 deletions(-)
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c

-- 
2.7.4
