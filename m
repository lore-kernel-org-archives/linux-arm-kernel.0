From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Dec 2015 15:39:08 -0800
Subject: [GIT PULL] omap fixes against v4.4-rc4
Message-ID: <20151210233907.GI23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/fixes-rc4

for you to fetch changes up to 14054fb1da099fd89208b8b319a00e0b902c7645:

  ARM: dts: am4372: fix clock source for arm twd and global timers (2015-12-09 16:46:25 -0800)

----------------------------------------------------------------
Few fixes for omaps for v4.4-rc cycle:

- Fix clock source for ARM TWD and global timers on am437x

- Always select REGULATOR_FIXED_VOLTAGE for omap2+ instead of
  when MACH_OMAP3_PANDORA is selected

- Fix SPI DMA handles for dm816x as only some were mapped

- Fix up mbox cells for dm816x to make mailbox usable

----------------------------------------------------------------
Grygorii Strashko (2):
      ARM: OMAP2+: enable REGULATOR_FIXED_VOLTAGE
      ARM: dts: am4372: fix clock source for arm twd and global timers

Neil Armstrong (2):
      ARM: dts: add dm816x missing #mbox-cells
      ARM: dts: add dm816x missing spi DT dma handles

 arch/arm/boot/dts/am4372.dtsi        | 4 ++--
 arch/arm/boot/dts/am43xx-clocks.dtsi | 8 ++++++++
 arch/arm/boot/dts/dm816x.dtsi        | 8 ++++++--
 arch/arm/mach-omap2/Kconfig          | 2 +-
 4 files changed, 17 insertions(+), 5 deletions(-)
