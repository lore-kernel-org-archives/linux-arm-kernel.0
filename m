From: olof@lixom.net (Olof Johansson)
Date: Sat, 16 Jul 2016 21:56:23 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20160717045623.GA2476@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:

  Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 5eb495349f5ec3b134f7341a2450392fc86d99d0:

  ARM: tegra: beaver: Allow SD card voltage to be changed (2016-07-06 22:21:40 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A handful of fixes before final release:

Marvell Armada:
 - One to fix a typo in the devicetree specifying memory ranges for the
   crypto engine
 - Two to deal with marking PCI and device-memory as strongly ordered to
   avoid hardware deadlocks, in particular when enabling above crypto driver.
 - Compile fix for PM

Allwinner:
 - DT clock fixes to deal with u-boot-enabled framebuffer (simplefb).
 - Make R8 (C.H.I.P. SoC) inherit system compatibility from A13 to
   make clocks register proper.

Tegra:
 - Fix SD card voltage setting on the Tegra3 Beaver dev board

Misc:
 - Two maintainers updates for STM32 and STi platforms.

----------------------------------------------------------------
Arnd Bergmann (3):
      ARM: mvebu: compile pm code conditionally
      Merge tag 'sunxi-fixes-for-4.7' of https://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'mvebu-fixes-4.7-2' of git://git.infradead.org/linux-mvebu into fixes

Boris Brezillon (1):
      ARM: sunxi/dt: make the CHIP inherit from allwinner,sun5i-a13

Hans de Goede (2):
      ARM: dts: sunxi: Add pll3 to simplefb nodes clocks lists
      ARM: dts: sun7i: Fix pll3x2 and pll7x2 not having a parent clock

Lucas Stach (1):
      ARM: tegra: beaver: Allow SD card voltage to be changed

Maxime Coquelin (2):
      MAINTAINERS: update STM32 maintainers list
      MAINTAINERS: update STi maintainer list

Olof Johansson (1):
      Merge tag 'mvebu-fixes-4.7-1' of git://git.infradead.org/linux-mvebu into fixes

Thomas Petazzoni (3):
      ARM: mvebu: fix HW I/O coherency related deadlocks
      ARM: mvebu: map PCI I/O regions strongly ordered
      ARM: dts: armada-38x: fix MBUS_ID for crypto SRAM on Armada 385 Linksys

 MAINTAINERS                               |  3 +--
 arch/arm/boot/dts/armada-385-linksys.dtsi |  4 ++--
 arch/arm/boot/dts/sun4i-a10.dtsi          | 21 ++++++++++++---------
 arch/arm/boot/dts/sun5i-a10s.dtsi         | 11 ++++++-----
 arch/arm/boot/dts/sun5i-r8-chip.dts       |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi          | 13 ++++++++-----
 arch/arm/boot/dts/tegra30-beaver.dts      |  3 ++-
 arch/arm/mach-mvebu/Makefile              | 10 ++++++++--
 arch/arm/mach-mvebu/coherency.c           | 23 +++++++++--------------
 9 files changed, 49 insertions(+), 41 deletions(-)
