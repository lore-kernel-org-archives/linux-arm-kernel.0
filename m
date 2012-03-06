From: khilman@ti.com (Kevin Hilman)
Date: Mon, 05 Mar 2012 16:53:29 -0800
Subject: [GIT PULL] ARM: OMAP: PM cleanups for v3.4
Message-ID: <87mx7uh7na.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following PM related cleanups for v3.4.

Note that due to conflicts with changes from both your cleanup branch
and your hsmmc branch, I created a merge base by starting at 'cleanup'
and merging hsmmc, and basing this series on top.

Let me know if you want some other baseline for this series.

Kevin


The following changes since commit 015f1e4297ad32f83251f3f4cee2389ce5516e9e:

  Merge remote-tracking branch 'omap/hsmmc' into for_3.4/cleanup/pm-base (2012-03-05 15:37:04 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cleanup/pm

for you to fetch changes up to 1416408d31236dc2a80d269aa23ffa93aa01e833:

  ARM: OMAP2+: PM: share some suspend-related functions across OMAP2, 3, 4 (2012-03-05 16:01:19 -0800)

----------------------------------------------------------------
Jean Pihet (1):
      ARM: OMAP2+: PM debug: fix the use of debugfs_create_* API

Kevin Hilman (1):
      ARM: OMAP: omap_device: remove omap_device_parent

Paul Walmsley (5):
      ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
      ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()
      ARM: OMAP2+: PM: share clkdms_setup() across OMAP2, 3, 4
      ARM: OMAP2+: omap_device: call all suspend, resume callbacks when OMAP_DEVICE_NO_IDLE_ON_SUSPEND is set
      ARM: OMAP2+: PM: share some suspend-related functions across OMAP2, 3, 4

 arch/arm/mach-omap2/omap-mpuss-lowpower.c     |    2 -
 arch/arm/mach-omap2/pm-debug.c                |    6 +-
 arch/arm/mach-omap2/pm.c                      |  113 ++++++++++++++++++++-----
 arch/arm/mach-omap2/pm.h                      |    2 +
 arch/arm/mach-omap2/pm24xx.c                  |   75 ++--------------
 arch/arm/mach-omap2/pm34xx.c                  |   74 +---------------
 arch/arm/mach-omap2/pm44xx.c                  |   57 +------------
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |    2 +-
 arch/arm/plat-omap/omap_device.c              |   24 ++----
 10 files changed, 118 insertions(+), 239 deletions(-)
