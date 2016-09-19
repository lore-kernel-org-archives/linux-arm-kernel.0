From: kraxel@redhat.com (Gerd Hoffmann)
Date: Mon, 19 Sep 2016 10:43:16 +0200
Subject: [PATCH v4 0/7] ARM: dts: bcm283x: add and use pinctrl groups
Message-ID: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

New in v4:  Patch #6 has been splitted into two:  Patch 6 just moves
pinctrl from &gpio to &sdhci.  Removing the empty now alt3 group
-- including all references as pointed out by Stefan Wahren in review --
is done by the new patch 7.  Patches 1-5 are unchanged.

cheers,
  Gerd

Eric Anholt (1):
  ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.

Gerd Hoffmann (6):
  pinctrl: bcm2835: add pull defines to dt bindings
  ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio
  ARM: dts: bcm283x: drop alt3 from &gpio

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |   2 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts      |   2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |   2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |   2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts      |   2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts   |   2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi       |  15 ++-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi           | 203 +++++++++++++++++++++++++++++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c    |   6 -
 include/dt-bindings/pinctrl/bcm2835.h    |   5 +
 11 files changed, 224 insertions(+), 19 deletions(-)

-- 
1.8.3.1
