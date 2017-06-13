From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Jun 2017 13:10:39 -0700
Subject: [GIT PULL 2/7] Broadcom devicetree changes for 4.13 (v2)
In-Reply-To: <20170613201044.9808-1-f.fainelli@gmail.com>
References: <20170613201044.9808-1-f.fainelli@gmail.com>
Message-ID: <20170613201044.9808-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/devicetree

for you to fetch changes up to 4a579ecf3d4f964bd6b39605610201cd4d5a7e8e:

  Merge tag 'bcm2835-dt-next-2017-06-12' into devicetree/next (2017-06-13 12:38:48 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based Device Tree changes for 4.13.

Note that Baruch's changes are fixes that are currently included in v4.12-rc2,
but they are also included here in order to keep this tag based off v4.12-rc1.

Please pull the following:

- Rafal adds CPU and thermal zones to the Northstar (BCM5301X) Device Tree and he
  also adds the MDIO controller nodes for later use by USB PHYs

- Eric adds support for the V3D engine and Ethernet switch on the Cygnus
  platforms, he also adds a set of Device Tree sources and include files for the
  Raspberry Pi 3 (BCM2837) to be used with the ARM/Linux kernel,

- Jon adds CPU and thermal zones to the Northstar Plus Device Tree files

- Stefan updates the Raspberry Pi DTS files with thermal trip points and zones,
  adds support for the USB OTG on the Raspberry Pi Zero which includes the
  proper dwc2 configuration, a generic USB PHY and finally the enabling of the
  OTG controller by including the proper DTS include file

- Gerd switches the Raspberry Pi DTS files to use the SDHOST controller (faster
  than the SDHCI)

----------------------------------------------------------------
Baruch Siach (4):
      ARM: dts: bcm2835: fix uart0 pinctrl node names
      ARM: dts: bcm2835: fix i2c0 pins
      ARM: dts: bcm2835: fix uart0/uart1 pins
      ARM: dts: bcm2835: add index to the ethernet alias

Eric Anholt (3):
      ARM: dts: Add devicetree for the Raspberry Pi 3, for arm32 (v6)
      ARM: dts: Cygnus: Add BCM11360's V3D device
      ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY

Florian Fainelli (2):
      Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/next
      Merge tag 'bcm2835-dt-next-2017-06-12' into devicetree/next

Gerd Hoffmann (1):
      ARM: dts: bcm283x: switch from &sdhci to &sdhost

Jon Mason (1):
      ARM: dts: NSP: Add Thermal Support

Rafa? Mi?ecki (2):
      ARM: dts: BCM5301X: Add CPU thermal sensor and zone
      ARM: dts: BCM5301X: Specify MDIO bus in the DT

Stefan Wahren (4):
      ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
      ARM: dts: bcm283x: Add dtsi for OTG mode
      ARM: dts: bcm283x: Add generic USB PHY
      ARM: dts: bcm2835-rpi-zero: Enable OTG mode

 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/bcm-cygnus.dtsi           | 71 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm-nsp.dtsi              | 26 +++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts      |  2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi          |  2 +-
 arch/arm/boot/dts/bcm2835.dtsi              |  4 ++
 arch/arm/boot/dts/bcm2836.dtsi              |  4 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts       |  1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi  | 10 ++++
 arch/arm/boot/dts/bcm283x.dtsi              | 49 ++++++++++++++++----
 arch/arm/boot/dts/bcm5301x.dtsi             | 34 ++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts      | 20 ++++++++
 14 files changed, 215 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi
