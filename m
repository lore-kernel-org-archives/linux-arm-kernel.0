From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 17 Nov 2016 22:50:33 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.10 (#1)
Message-ID: <87poltbwt2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.10.

I hope being able to send a second part very soon with the series
removing all the DT warning.

Gregory

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.10-1

for you to fetch changes up to cf20c489de6fcef88405d4febef7a078d2053b9e:

  ARM: dt: orion5x: convert ls-chl to FDT (2016-11-07 17:23:34 +0100)

----------------------------------------------------------------
mvebu fixes for 4.10 (part 1)

Most of the commit are pinmux and i2c fix for netgear NASes
Fix on a wrong comment about PLL frequency
Bigger commit: conversion of on otion5x based board to the device tree

----------------------------------------------------------------
Ashley Hughes (1):
      ARM: dt: orion5x: convert ls-chl to FDT

Chris Packham (1):
      ARM: dts: mvebu: Update comment for main PLL frequency

Uwe Kleine-K?nig (6):
      ARM: dts: armada-370-rn104: add pinmuxing for i2c0
      ARM: dts: armada-370-rn104: drop specification of compatible for i2c0
      ARM: dts: armada-xp-rn2120: drop wrong compatible for i2c0
      ARM: dts: armada-xp-rn2120: add pinmuxing for ethernet
      ARM: dts: armada-370-rn102: drop specification of compatible for i2c0
      ARM: dts: armada-370-rn102: add pinmuxing for i2c0

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts |   5 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts |   5 +-
 arch/arm/boot/dts/armada-375.dtsi              |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi              |   2 +-
 arch/arm/boot/dts/armada-39x.dtsi              |   2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts |   7 +-
 arch/arm/boot/dts/orion5x-lschl.dts            | 171 +++++++++++++
 arch/arm/mach-orion5x/Kconfig                  |   4 +-
 arch/arm/mach-orion5x/Makefile                 |   1 -
 arch/arm/mach-orion5x/ls-chl-setup.c           | 331 -------------------------
 11 files changed, 191 insertions(+), 340 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-lschl.dts
 delete mode 100644 arch/arm/mach-orion5x/ls-chl-setup.c
