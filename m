From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 11:39:18 -0700
Subject: [GIT PULL 6/10] omap hwmod data additions for v3.5,
 depends on devel-prcm
In-Reply-To: <pull-1336675159-747052>
Message-ID: <mailman.12.1336675195.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 743a6d923f803c861a24d173e1d1818ca8ac0384:

  Merge tag 'omap-devel-b-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-prcm (2012-05-08 11:49:09 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-hwmod-data-for-v3.5

for you to fetch changes up to bfd17879866b36e95c58721da070d9f2ac7f8901:

  Merge tag 'omap-devel-c-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-hwmod-data (2012-05-09 09:58:42 -0700)

----------------------------------------------------------------

Data changes related to omap hwmod

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: OMAP2+: WDTIMER integration: fix !PM boot crash, disarm timer after hwmod reset

Paul Walmsley (4):
      ARM: OMAP2+: HDQ1W: add custom reset function
      ARM: OMAP2+: hwmod data: add HDQ/1-wire hwmod shared data
      ARM: OMAP3: hwmod data: add HDQ/1-wire hwmod
      ARM: OMAP2xxx: hwmod data: add HDQ/1-wire hwmod

Peter Ujfalusi (2):
      ARM: OMAP3: hwmod_data: Rename the common irq for McBSP ports
      ARM: OMAP4: hwmod_data: Name the common irq for McBSP ports

Shubhrajyoti D (1):
      ARM: OMAP4: hwmod data: I2C: add flag for context restore

Tony Lindgren (2):
      ARM: OMAP2420: hwmod data: Add MMC hwmod data for 2420
      Merge tag 'omap-devel-c-for-3.5' of git://git.kernel.org/.../pjw/omap-pending into devel-hwmod-data

Vaibhav Hiremath (1):
      ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod database

 arch/arm/mach-omap2/Makefile                       |    5 +-
 arch/arm/mach-omap2/hdq1w.c                        |   72 +++++++++++++
 arch/arm/mach-omap2/io.c                           |   18 ----
 arch/arm/mach-omap2/msdi.c                         |   88 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  112 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   47 ++++++++
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |    9 ++
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   22 ++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   23 +++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   94 ++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   12 ++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    5 +
 arch/arm/mach-omap2/wd_timer.c                     |   45 ++++++++
 arch/arm/mach-omap2/wd_timer.h                     |    1 +
 arch/arm/plat-omap/include/plat/hdq1w.h            |   36 +++++++
 arch/arm/plat-omap/include/plat/mmc.h              |    4 +
 16 files changed, 562 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hdq1w.c
 create mode 100644 arch/arm/mach-omap2/msdi.c
 create mode 100644 arch/arm/plat-omap/include/plat/hdq1w.h
