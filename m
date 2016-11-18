From: eric@anholt.net (Eric Anholt)
Date: Fri, 18 Nov 2016 10:58:33 -0800
Subject: [GIT PULL 2/4] bcm2835-dt-64-next-2016-11-18
In-Reply-To: <20161118185835.14452-1-eric@anholt.net>
References: <20161118185835.14452-1-eric@anholt.net>
Message-ID: <20161118185835.14452-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-dt-64-next-2016-11-18

for you to fetch changes up to a44e87b47148c6ee6b78509f47e6a15c0fae890a:

  ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED (2016-11-16 13:49:38 -0800)

----------------------------------------------------------------
This pull request brings thermal support to the BCM2837 DT, and a few
other fixes.

In order to get the thermal node that we're adjusting the compatible
string on, we have to merge in the bcm2835-dt-next branch.

----------------------------------------------------------------
Andrea Merello (1):
      ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED

Andreas F?rber (1):
      ARM64: dts: bcm2835: Fix bcm2837 compatible string

Eric Anholt (2):
      ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.
      Merge branch 'bcm2835-dt-next' into bcm2835-dt-64-next

Gerd Hoffmann (6):
      pinctrl: bcm2835: add pull defines to dt bindings
      ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio
      ARM: dts: bcm283x: drop alt3 from &gpio

Linus Walleij (1):
      ARM: bcm2835: Add names for the Raspberry Pi GPIO lines

Martin Sperl (3):
      dt: bindings: add thermal device driver for bcm2835
      ARM: bcm2835: dts: add thermal node to device-tree of bcm283x
      ARM64: bcm2835: dts: add thermal node to device-tree of bcm2837

Stefan Wahren (3):
      ARM64: dts: bcm283x: Use dtsi for USB host mode
      DT: binding: bcm2835-mbox: fix address typo in example
      ARM: dts: bcm283x: fix typo in mailbox address

 .../bindings/mailbox/brcm,bcm2835-mbox.txt         |   2 +-
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  17 ++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  67 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  69 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  68 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  68 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  69 ++++++-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  15 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |   6 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   2 +-
 arch/arm/boot/dts/bcm2836.dtsi                     |   6 +
 arch/arm/boot/dts/bcm283x.dtsi                     | 212 ++++++++++++++++++++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |   8 +-
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |   8 +-
 .../boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi    |   1 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 -
 include/dt-bindings/pinctrl/bcm2835.h              |   5 +
 18 files changed, 602 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
