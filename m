From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 16:34:51 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.7 (#1)
Message-ID: <87r3dosctw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.7.

Gregory

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.7-1

for you to fetch changes up to 19b67d5c8b2dbef9a10bc1aeb96a861c57a0bdf8:

  arm64: dts: marvell: add XOR node for Armada 3700 SoC (2016-04-29 15:07:42 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.7

- switch to label in the mvebu arm64 device tree
- use new clock binding on Armada 7K/8K
- improve SPI and I2C description on Armada 7K/8k
- add CP110 block adding PCIe, SATA and USB3
- add XOR support on Armada 3700
- few more little fix

----------------------------------------------------------------
Andreas F?rber (4):
      arm64: dts: marvell: clean up armada-7040-db
      arm64: dts: marvell: rename armada-ap806 XOR nodes
      arm64: dts: marvell: Clean up armada-3720-db
      arm64: dts: marvell: Rename armada-37xx USB node

Gregory CLEMENT (2):
      arm64: dts: marvell: Use a SoC-specific compatible for xHCI on Armada37xx
      arm64: dts: marvell: add XOR node for Armada 3700 SoC

Thomas Petazzoni (6):
      arm64: dts: marvell: add UART aliases and define stdout-path
      arm64: dts: marvell: use new clock binding on Armada AP806
      arm64: dts: marvell: improve SPI flash description on Armada 7040-DB
      arm64: dts: marvell: use the proper I2C controller compatible string for 7K/8K
      arm64: dts: marvell: initial DT description of Armada 7K/8K CP110 master
      arm64: dts: marvell: enable several CP interfaces on Armada 7040-DB

 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  32 ++-
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  20 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 108 +++++++---
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |   1 -
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |   2 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  56 +++--
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 228 +++++++++++++++++++++
 13 files changed, 368 insertions(+), 85 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
