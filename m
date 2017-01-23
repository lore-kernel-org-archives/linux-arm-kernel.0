From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 23 Jan 2017 11:54:41 +0800
Subject: [PATCH 0/4] leds: add leds-mt6323 support on MT7623 SoC
Message-ID: <1485143685-11808-1-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

MT7623 SoC uses MT6323 PMIC as the default power supply
which has LED function insides. The patchset introduces
the LED support for MT6323 with on, off and hardware
dimmed and blinked and it should work on other similar
SoCs if also using MT6323.

Sean Wang (4):
  Documentation: devicetree: Add document bindings for leds-mt6323
  Documentation: devicetree: Add LED subnode binding for MT6323 PMIC
  leds: Add LED support for MT6323 PMIC
  mfd: mt6397: Add MT6323 LED support into MT6397 driver

 .../devicetree/bindings/leds/leds-mt6323.txt       |  60 ++++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   4 +
 drivers/leds/Kconfig                               |   8 +
 drivers/leds/Makefile                              |   3 +
 drivers/leds/leds-mt6323.c                         | 390 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   4 +
 6 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
 create mode 100644 drivers/leds/leds-mt6323.c

-- 
1.9.1
