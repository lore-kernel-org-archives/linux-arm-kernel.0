From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 09 Feb 2016 11:04:49 +0100
Subject: [GIT PULL v2] ARM: mvebu: dt for v4.6 (#1)
Message-ID: <87twliyzb2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second version of the first pull request for dt for mvebu
for v4.6.  This one is based on v4.5-rc3 because it depends on fixes
merged previously.

As requested by Olof, I aligned the commit title.

Gregory

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.6-1

for you to fetch changes up to 5dda254d0cc5cbdcc81dbce0985c35b68dd5e3b1:

  ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl (2016-02-09 11:00:26 +0100)

----------------------------------------------------------------
mvebu dt for 4.6 (part 1)

- Improve Armada 38x device tree (SATA and XHCI)
- Fix SD Card and audio support for OpenRD board
- Provide template for RS-232/485 configuration for the same board
- Use a common dtsi file for linkstation boards
- Add support for Buffalo Linkstation LS-QVL

----------------------------------------------------------------
Aaro Koskinen (4):
      ARM: dts: kirkwood: fix pin names for UART/SD selection for OpenRD
      ARM: dts: kirkwood: fix SD slot default configuration for OpenRD
      ARM: dts: kirkwood: provide template for RS-232/485 configuration for OpenRD
      ARM: dts: kirkwood: fix audio for OpenRD clients

Gregory CLEMENT (2):
      ARM: dts: armada-38x: use usb-nop-xceiv PHY for the xhci nodes on Armada 388 GP
      ARM: dts: armada-370: Update the mpp63 function in the device tree on Armada 370

Mario Lange (1):
      ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl

Roger Shimizu (3):
      ARM: dts: kirkwood: relicense dts of ls-wvl/vl and ls-wxl/wsxl under GPLv2/X11
      ARM: dts: kirkwood: split lswxl dts to linkstation lswsxl and lswxl
      ARM: dts: kirkwood: split lswvl dts to linkstation lsvl and lswvl

Thomas Petazzoni (2):
      ARM: dts: armada-38x: adjust board name and compatible for Armada 388 GP
      ARM: dts: armada-38x: use regulator-boot-on for SATA regulators on Armada 388 GP

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   7 +-
 .../pinctrl/marvell,armada-370-pinctrl.txt         |   5 +-
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |   2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |   2 +-
 arch/arm/boot/dts/armada-388-gp.dts                |  36 +--
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   | 192 +++++++++++++
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    | 186 +++++++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   | 135 +++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |  57 ++++
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  |  57 ++++
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   | 112 ++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   | 116 ++++++++
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        | 202 ++++++++++++++
 arch/arm/boot/dts/kirkwood-lswvl.dts               | 302 ---------------------
 arch/arm/boot/dts/kirkwood-lswxl.dts               | 302 ---------------------
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |   6 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |  41 ++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 20 files changed, 1137 insertions(+), 634 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation.dtsi
 delete mode 100644 arch/arm/boot/dts/kirkwood-lswvl.dts
 delete mode 100644 arch/arm/boot/dts/kirkwood-lswxl.dts
