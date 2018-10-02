From: tony@atomide.com (Tony Lindgren)
Date: Tue,  2 Oct 2018 07:53:03 -0700
Subject: [GIT PULL] more dts changes for omaps for v4.20
Message-ID: <pull-1538491958-348872@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 20bcd4a4d76d7474047ff4539e7d65b990bb2556:

  ARM: dts: add omap3-gta04a5one to Makefile (2018-09-27 08:29:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/dt-signed-part2

for you to fetch changes up to 5f681f41fe1714e9961dcba2e98adea2a0daf9c5:

  ARM: dts: am335x: Replace remaining legacy phy_id with phy-handle (2018-09-28 13:36:48 -0700)

----------------------------------------------------------------
More devicetree changes for omap variants

There's a patch for previously merged dts changes to remove the last
remaining use of legacy phy_id property.

For dra7, we have a non-urgent PCIe dts fix, enable a PCIe errata for
unaligned access.

For omap5, we enable omap5 USB OTG mode for DWC3 controller.

And we add support for am335x based Moxa UC-2100 series of industrial
computers.

----------------------------------------------------------------
H. Nikolaus Schaller (1):
      ARM: dts: omap5: enable OTG role for DWC3 controller

SZ Lin (???) (2):
      ARM: dts: am335x: add common file for UC-2100 series
      ARM: dts: am335x: add support for Moxa UC-2101 open platform

Tony Lindgren (1):
      ARM: dts: am335x: Replace remaining legacy phy_id with phy-handle

Vignesh R (2):
      ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
      ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi | 249 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts         |  69 ++++++
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts       |   6 +-
 arch/arm/boot/dts/am335x-sancloud-bbe.dts         |   6 +-
 arch/arm/boot/dts/dra7.dtsi                       |   4 +-
 arch/arm/boot/dts/omap5-board-common.dtsi         |   4 +
 7 files changed, 336 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts
