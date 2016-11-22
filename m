From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 Nov 2016 21:48:21 -0800
Subject: [GIT PULL 3/6] Broadcom devicetree-arm64 changes for 4.10
In-Reply-To: <20161122054824.16974-1-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
Message-ID: <20161122054824.16974-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.10/devicetree-arm64

for you to fetch changes up to e687607116bc45afcbbcd0097129573f9729ff21:

  Merge tag 'bcm2835-dt-64-next-2016-11-18' into devicetree-arm64/next (2016-11-21 21:09:19 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM64 based SoC Device Tree changes for
4.10, please pull the following:

- Robin updates the Northstart 2 DTS to use the generic IOMMU binding

- Scott renames the Broadcom Northstar 2 binding document to use a standard name
  including the brcm vendor prefix

- Kamal adds the QSPI Device Tree node to the Northstar 2 SoC and updates the
  Northstar 2 SVK reference board DTS file with it enabled.

- Rob adds the Device Tree node for the Broadcom PDC (mailbox) hardware to the
  Northstar 2 SoC

- Jon enables the SDIO1 block and adds proper PCIe PHYs Device Tree nodes to the
  Northstar 2 SoC

- Ray adds required properties NAND controller properties to make NAND work on
  the Northstar 2 SVK board, this was submitted as a 4.9 fixes and is included
  here to resolve DTS file merges

- Andrea removes an incorrect power LED from the Raspberry Pi 3 DTS

- Andreas fixes the compatible string for the BCM2837 (Raspberry Pi 3)

- Eric defines standard pinctrl groups in the BCM2835 GPIO node

- Gerd adds definitions for the pinctrl groups and updates the PWM, I2C and SDHCI nodes
  to use their appropriate pinctrl functions

- Linus adds names for the Raspberry Pi GPIO lines based on the datasheet

- Martin adds the DT binding and nodes for the Raspberry Pi firmware thermal block

- Stefan fixes a few typos with respect to the BCM2835 mailbox binding example and
  Device Tree nodes he also uses the proper DTSI file to define the USB host mode
  for the USB Device Tree nodes

----------------------------------------------------------------
Andrea Merello (1):
      ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED

Andreas F?rber (1):
      ARM64: dts: bcm2835: Fix bcm2837 compatible string

Eric Anholt (2):
      ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.
      Merge branch 'bcm2835-dt-next' into bcm2835-dt-64-next

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-64-next-2016-11-18' into devicetree-arm64/next

Gerd Hoffmann (6):
      pinctrl: bcm2835: add pull defines to dt bindings
      ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio
      ARM: dts: bcm283x: drop alt3 from &gpio

Jon Mason (2):
      arm64: dts: NS2: enable sdio1
      arm64: dts: NS2: Add PCI PHYs

Kamal Dasu (1):
      ARM64: dts: Add QSPI Device Tree node for NS2

Linus Walleij (1):
      ARM: bcm2835: Add names for the Raspberry Pi GPIO lines

Martin Sperl (3):
      dt: bindings: add thermal device driver for bcm2835
      ARM: bcm2835: dts: add thermal node to device-tree of bcm283x
      ARM64: bcm2835: dts: add thermal node to device-tree of bcm2837

Ray Jui (1):
      arm64: dts: Updated NAND DT properties for NS2 SVK

Rob Rice (1):
      arm64: dts: Add Broadcom Northstar2 device tree entries for PDC driver.

Robin Murphy (1):
      arm64: dts: Update Broadcom NS2 to generic IOMMU binding

Scott Branden (1):
      arm64: dts: rename ns2.txt to brcm,ns2.txt

Stefan Wahren (3):
      ARM64: dts: bcm283x: Use dtsi for USB host mode
      DT: binding: bcm2835-mbox: fix address typo in example
      ARM: dts: bcm283x: fix typo in mailbox address

 .../bindings/arm/bcm/{ns2.txt => brcm,ns2.txt}     |   0
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
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  40 ++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  62 +++++-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 -
 include/dt-bindings/pinctrl/bcm2835.h              |   5 +
 21 files changed, 703 insertions(+), 30 deletions(-)
 rename Documentation/devicetree/bindings/arm/bcm/{ns2.txt => brcm,ns2.txt} (100%)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
