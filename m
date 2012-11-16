From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 16 Nov 2012 11:17:16 -0600
Subject: [GIT PULL] ARM: OMAP: Timer Clean-up
Message-ID: <50A6751C.6080800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:

  Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)

are available in the git repository at:

  git://github.com/jonhunter/linux.git cleanup-timer

for you to fetch changes up to 258e84af9799b8c81cf856dcbd8e2d4cc082741d:

  ARM: OMAP2+: Fix compiler warning for 32k timer (2012-11-16 10:35:09 -0600)

----------------------------------------------------------------
Various OMAP timer clean-ups.

I have dropped the patch to move dmtimer.h as discussed.

I have also included the compilation warning fix for sync-32k
reported by Kevin Hilman.
----------------------------------------------------------------
Jon Hunter (8):
      ARM: OMAP: Clean-up dmtimer reset code
      ARM: OMAP: Define omap_dm_timer_prepare function as static
      ARM: OMAP: Don't store timers physical address
      ARM: OMAP2+: Remove unnecessary local variable in timer code
      ARM: OMAP: Remove unnecessary omap_dm_timer structure declaration
      ARM: OMAP: Add platform data header for DMTIMERs
      ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
      ARM: OMAP2+: Fix compiler warning for 32k timer

 arch/arm/mach-omap1/timer.c                |    1 +
 arch/arm/mach-omap1/timer32k.c             |    1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 -
 arch/arm/mach-omap2/pm-debug.c             |    1 -
 arch/arm/mach-omap2/timer.c                |   36 ++++++-------
 arch/arm/plat-omap/dmtimer.c               |   54 ++++++++++++-------
 arch/arm/plat-omap/include/plat/dmtimer.h  |   80 ++++++++--------------------
 drivers/staging/tidspbridge/core/ue_deh.c  |    1 -
 include/linux/platform_data/dmtimer-omap.h |   31 +++++++++++
 10 files changed, 105 insertions(+), 102 deletions(-)
 create mode 100644 include/linux/platform_data/dmtimer-omap.h
