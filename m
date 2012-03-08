From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 12:53:29 -0800
Subject: [GIT PULL 3/7] PM clean-up for the upcoming merge window
In-Reply-To: <pull-1331240009-558004>
Message-ID: <mailman.5.1331240029.14256.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This contains PM clean-up for the upcoming merge window.

As this was conflicting with both already queued cleanup
and hsmmc in fixes-non-critical branches, Kevin based the
series on a merge of the two. Suggest pulling this into
cleanup, this makes cleanup depend on fixes-non-critical,
which I believe already the case.


The following changes since commit 015f1e4297ad32f83251f3f4cee2389ce5516e9e:
  Kevin Hilman (1):
        Merge remote-tracking branch 'omap/hsmmc' into for_3.4/cleanup/pm-base

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap cleanup-pm

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

Tony Lindgren (1):
      Merge branch 'for_3.4/cleanup/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into cleanup-pm

 arch/arm/mach-omap2/omap-mpuss-lowpower.c     |    2 -
 arch/arm/mach-omap2/pm-debug.c                |    6 +-
 arch/arm/mach-omap2/pm.c                      |  113 ++++++++++++++++++++-----
 arch/arm/mach-omap2/pm.h                      |    2 +
 arch/arm/mach-omap2/pm24xx.c                  |   75 ++---------------
 arch/arm/mach-omap2/pm34xx.c                  |   74 +----------------
 arch/arm/mach-omap2/pm44xx.c                  |   57 +------------
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |    2 +-
 arch/arm/plat-omap/omap_device.c              |   24 ++----
 10 files changed, 118 insertions(+), 239 deletions(-)
