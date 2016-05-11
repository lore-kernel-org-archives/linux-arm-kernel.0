From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 May 2016 09:34:20 +0200
Subject: [PATCH v2 0/2] pinctrl: Oxford Semiconductor OXNAS pinctrl and gpio
 support
Message-ID: <1462952062-5316-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes support for the pinctrl and gpio controller of the
Oxford Semiconductor OXNAS SoC Family.

Changes since v1 : http://lkml.kernel.org/r/1459689969-5326-1-git-send-email-narmstrong at baylibre.com
- Fix gpio bindings
- remove irqd_to_bank abstraction

It was originally posted part of a platform patchset available here :
http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

Changes since v3 global patchset :
- Get rid of PLX Technology, replace by Oxford Semiconductor
- Get rid of gpio-bank and ngpios properties, now using gpio-ranges

Neil Armstrong (2):
  pinctrl: Add Oxford Semiconductor OXNAS pinctrl and gpio driver
  dt-bindings: Add Oxford Semiconductor OXNAS pinctrl and gpio bindings

 .../devicetree/bindings/gpio/gpio_oxnas.txt        |  47 ++
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |  57 ++
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-oxnas.c                    | 835 +++++++++++++++++++++
 5 files changed, 951 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-oxnas.c

-- 
1.9.1
