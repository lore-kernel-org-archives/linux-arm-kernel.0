From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 11:39:18 -0700
Subject: [GIT PULL 7/10] omap device init clean-up for v3.5
In-Reply-To: <pull-1336675159-747052>
Message-ID: <mailman.13.1336675204.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 65c98038394e65228490ef44353f5d4665690f55:

  Merge branch 'fixes-non-critical' into cleanup-devices (2012-05-09 14:32:44 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-devices-for-v3.5

for you to fetch changes up to 6c432f72b2bd75f7c427eec5558c72f62b35d4a0:

  ARM: OMAP1: Pass dma request lines in platform data to MMC driver (2012-05-09 16:35:12 -0700)

----------------------------------------------------------------
Changes to split plat-omap/devices.c into mach-omap1 and mach-omap2
except for the RNG driver that will be done later on.

As this depends on omap-devel-hwmod-data-for-v3.5 and causes merge
conflict with omap-fixes-non-critical-for-v3.5, this branch is based
on merge of the two.

----------------------------------------------------------------
Tony Lindgren (6):
      ARM: OMAP1: Move omap_init_audio() to keep the devices in alphabetical order
      ARM: OMAP1: Move omap_init_uwire to mach-omap1
      ARM: OMAP2+: Move omap_dsp_reserve_sdram_memblock() to mach-omap2
      ARM: OMAP2: Use hwmod to initialize mmc for 2420
      ARM: OMAP: Move omap_mmc_add() to mach-omap1
      ARM: OMAP1: Pass dma request lines in platform data to MMC driver

 arch/arm/mach-omap1/devices.c         |  121 +++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/devices.c         |   19 ++++-
 arch/arm/mach-omap2/dsp.c             |   27 +++++++-
 arch/arm/plat-omap/devices.c          |  122 ---------------------------------
 arch/arm/plat-omap/include/plat/mmc.h |    9 ---
 5 files changed, 151 insertions(+), 147 deletions(-)
