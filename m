From: eric@anholt.net (Eric Anholt)
Date: Fri, 18 Nov 2016 10:58:32 -0800
Subject: [GIT PULL 1/4] bcm2835-dt-next-2016-11-18
Message-ID: <20161118185835.14452-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-dt-next-2016-11-18

for you to fetch changes up to 3a1689ea752436917c5ce4487527ed6c444630ee:

  ARM: bcm2835: Add names for the RPi Zero GPIO lines (2016-11-16 13:54:36 -0800)

----------------------------------------------------------------
This pull request brings in DT changes for BCM2835: pinctrl setup
cleanups, GPIO line naming, and the node for the new thermal driver.

----------------------------------------------------------------
Eric Anholt (1):
      ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.

Gerd Hoffmann (6):
      pinctrl: bcm2835: add pull defines to dt bindings
      ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio
      ARM: dts: bcm283x: drop alt3 from &gpio

Linus Walleij (1):
      ARM: bcm2835: Add names for the Raspberry Pi GPIO lines

Martin Sperl (2):
      dt: bindings: add thermal device driver for bcm2835
      ARM: bcm2835: dts: add thermal node to device-tree of bcm283x

Stefan Wahren (4):
      DT: binding: bcm2835-mbox: fix address typo in example
      ARM: dts: bcm283x: fix typo in mailbox address
      ARM: bcm2835: Fix names for the Raspberry Pi GPIO lines
      ARM: bcm2835: Add names for the RPi Zero GPIO lines

 .../bindings/mailbox/brcm,bcm2835-mbox.txt         |   2 +-
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  17 ++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  67 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  69 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  68 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  68 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  69 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |  67 ++++++-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  15 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |   6 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   2 +-
 arch/arm/boot/dts/bcm2836.dtsi                     |   6 +
 arch/arm/boot/dts/bcm283x.dtsi                     | 212 ++++++++++++++++++++-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 -
 include/dt-bindings/pinctrl/bcm2835.h              |   5 +
 15 files changed, 658 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
