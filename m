From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  6 Jul 2016 20:36:12 -0700
Subject: [GIT PULL 1/4] Broadcom ARM devicetree changes for 4.8 (part 2)
In-Reply-To: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1467862574-6522-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2df1808dc0e2b5358e13beb95192b15200017776:

  ARM: dts: BCM5310x: Enable switch ports on SmartRG SR400AC (2016-06-13 12:44:46 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/devicetree-part2

for you to fetch changes up to 9a4865d42fe50650e37061da93441133786feac2:

  ARM: dts: NSP: Specify RAM amount for BCM958625HR board (2016-07-06 19:42:43 -0700)

----------------------------------------------------------------
This pull request contains additional Broadcom ARM-based SoC Device Tree changes:

- Lubomir updates all BCM2835 (Raspberry Pi family) Device Tree source files with
  their proper information about the on-board USB Ethernet adapter so there is
  appropriate binding between this USB device and a device_node (useful for MAC
  address fetching and stuff)

- Raveendra adds the ADC controller Device Tree nodes to the Cygnus SoC device
  tree include files

- Rafal updates the BCM5301x Device Tree by separating how we specify the NAND
  chip-select information in a first change and then fixes the NAND controller
  ECC configuration for the D-Link DIR-885L

- Florian adds support for the BCM953012ER reference board, adds the HW random
  number generator DT node and adds proper memory node information to the
  BCM958625HR reference board

----------------------------------------------------------------
Florian Fainelli (4):
      ARM: dts: BCM5301x: Add RNG Device Tree node
      ARM: dts: BCM5301x: Add BCM953012ER board
      Merge tag 'bcm2835-dt-next-2016-07-03' into devicetree/next
      ARM: dts: NSP: Specify RAM amount for BCM958625HR board

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add the ethernet to the device trees

Rafa? Mi?ecki (2):
      ARM: BCM5301X: Specify NAND chip select and ECC in separated files
      ARM: BCM5301X: Fix NAND ECC parameters for D-Link DIR-885L

Raveendra Padasalagi (1):
      ARM: dts: Cygnus: Add Broadcom iproc-static-adc DT node

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/bcm-cygnus.dtsi             |  11 +++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts      |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts      |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts           |   1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts         |   1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi   |  19 +++++
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi   |  19 +++++
 arch/arm/boot/dts/bcm283x.dtsi                |   2 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts |   2 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi |  15 ++++
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi |  16 ++--
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi      |  18 +++++
 arch/arm/boot/dts/bcm5301x.dtsi               |   5 ++
 arch/arm/boot/dts/bcm953012er.dts             | 104 ++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958625hr.dts             |   4 +
 16 files changed, 208 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
 create mode 100644 arch/arm/boot/dts/bcm953012er.dts
