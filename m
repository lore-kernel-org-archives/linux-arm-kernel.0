From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Oct 2015 12:34:01 -0700
Subject: [GIT PULL] two omap fixes for v4.3-rc cycle
Message-ID: <20151020193401.GM3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d8e1f5ed11a39a68da00f05000466c4f6db4456e:

  Documentation: ARM: List new omap MMC requirements (2015-10-12 16:23:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc6

for you to fetch changes up to 57df5380853460bc66b59a46273ce113c923d39c:

  ARM: OMAP2+: Fix imprecise external abort caused by bogus SRAM init (2015-10-19 08:55:46 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.3-rc cycle:

- Fix oops with LPAE and moew than 2GB of memory by enabling
  ZONE_DMA for LPAE. Probably no need for stable on this one as we
  only recently ran into this with the mainline kernel

- Fix imprecise external abort caused by bogus SRAM init. This affects
  dm814x recently merged, so no need for stable on this one AFAIK

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: OMAP2+: Fix oops with LPAE and more than 2GB of memory
      ARM: OMAP2+: Fix imprecise external abort caused by bogus SRAM init

 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |  2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts              |  2 +-
 arch/arm/mach-omap2/Kconfig                       |  2 ++
 arch/arm/mach-omap2/board-generic.c               | 10 ++++++++++
 arch/arm/mach-omap2/pdata-quirks.c                |  9 ++++++++-
 5 files changed, 22 insertions(+), 3 deletions(-)
