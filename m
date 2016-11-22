From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 Nov 2016 21:48:20 -0800
Subject: [GIT PULL 2/6] Broadcom devicetree changes for 4.10
In-Reply-To: <20161122054824.16974-1-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
Message-ID: <20161122054824.16974-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.10/devicetree

for you to fetch changes up to 509f8342993be7ce2938edacec05b6e8d780c83e:

  Merge tag 'bcm2835-dt-next-2016-11-18' into devicetree/next (2016-11-21 21:03:18 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Device Tree changes for 4.10,
please pull the following:

- Rafal adds support for the Netgear R8500 routers, adds basic support
  for the Tenda AC9 router which uses the new BCM53573 SoC (single core Cortex
  A7). He also enables the UART on the Netgear R8000 and restructures the
  include files a bit for the BCM47094 SoC, finally he adds USB 3.0 PHY nodes
  which enables USB 3.0 on BCM5301X devices that support it. Finally he adds
  support for the TP-LINK Archer C9 V1 router.

- Kamal adds support for the QSPI controller on the Northstar Plus SoCs and updates
  the bcm958625k reference board to have it enabled

- Dan adds support for the Luxul XAP-1510 (using a BCM4708) and XWR-3100 (using
  a BCM47094)

- Scott fixes the pinctrl names in the Cygnus DTS files

- Jonathan enables the Broadcom iProc mailbox controller for Broadcom Cygnus/iProc
  SoCs, he adds interrupt support for the GPIO CRMU hardware block and finally adds
  the node for the OTP controller found on Cygnus SoCs

- Dhananjay enables the GPIO B controller on Norstarh Plus SoCs

- Eric defines standard pinctrl groups in the BCM2835 GPIO node

- Gerd adds definitions for the pinctrl groups and updates the PWM, I2C and SDHCI nodes
  to use their appropriate pinctrl functions

- Linus adds names for the Raspberry Pi GPIO lines based on the datasheet

- Martin adds the DT binding and nodes for the Raspberry Pi firmware thermal block

- Stefan fixes a few typos with respect to the BCM2835 mailbox binding example and
  Device Tree nodes he also fixes the Raspberry Pi GPIO lines names and finally
  adds names for the Raspberry Zero GPIO lines

----------------------------------------------------------------
Dan Haab (2):
      ARM: BCM5301X: Add DT for Luxul XAP-1510
      ARM: BCM5301X: Add DT for Luxul XWR-3100

Eric Anholt (1):
      ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2016-11-18' into devicetree/next

Gerd Hoffmann (6):
      pinctrl: bcm2835: add pull defines to dt bindings
      ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio
      ARM: dts: bcm283x: drop alt3 from &gpio

Jonathan Richardson (3):
      ARM: dts: Enable Broadcom iProc mailbox controller
      ARM: dts: Enable interrupt support for cygnus crmu gpio driver
      ARM: dts: Add node for Broadcom OTP controller driver

Kamal Dasu (1):
      ARM: dts: NSP: Add QSPI nodes to NSPI and bcm958625k DTSes

Linus Walleij (1):
      ARM: bcm2835: Add names for the Raspberry Pi GPIO lines

Martin Sperl (2):
      dt: bindings: add thermal device driver for bcm2835
      ARM: bcm2835: dts: add thermal node to device-tree of bcm283x

Rafa? Mi?ecki (7):
      ARM: BCM5301X: Add DT for Netgear R8500
      ARM: BCM5301X: Add basic dts for BCM53573 based Tenda AC9
      ARM: BCM5301X: Add separated DTS include file for BCM47094
      ARM: BCM5301X: Enable UART on Netgear R8000
      ARM: BCM5301X: Specify USB 3.0 PHY in DT
      ARM: BCM53573: Specify PMU and its ILP clock in the DT
      ARM: BCM5301X: Add DT for TP-LINK Archer C9 V1

Scott Branden (1):
      ARM: dts: cygnus: fix naming of pinctrl node

Stefan Wahren (4):
      DT: binding: bcm2835-mbox: fix address typo in example
      ARM: dts: bcm283x: fix typo in mailbox address
      ARM: bcm2835: Fix names for the Raspberry Pi GPIO lines
      ARM: bcm2835: Add names for the RPi Zero GPIO lines

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: enable GPIO-b for Broadcom NSP

 .../bindings/mailbox/brcm,bcm2835-mbox.txt         |   2 +-
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |  17 ++
 arch/arm/boot/dts/Makefile                         |   6 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  21 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  41 +++-
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
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |  64 +++++++
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |   2 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   2 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |   2 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |   6 +-
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 114 +++++++++++
 arch/arm/boot/dts/bcm4709.dtsi                     |  11 ++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |   3 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      | 111 +++++++++++
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       | 103 ++++++++++
 arch/arm/boot/dts/bcm47094.dtsi                    |  17 ++
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts           |  74 +++++++
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi      |  13 ++
 arch/arm/boot/dts/bcm5301x.dtsi                    |   7 +
 arch/arm/boot/dts/bcm53573.dtsi                    | 159 ++++++++++++++++
 arch/arm/boot/dts/bcm958625k.dts                   |  34 ++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 -
 include/dt-bindings/pinctrl/bcm2835.h              |   5 +
 34 files changed, 1440 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 100644 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
 create mode 100644 arch/arm/boot/dts/bcm4709.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-netgear-r8500.dts
 create mode 100644 arch/arm/boot/dts/bcm47094.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47189-tenda-ac9.dts
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
 create mode 100644 arch/arm/boot/dts/bcm53573.dtsi
