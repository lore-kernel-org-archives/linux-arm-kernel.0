From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Feb 2011 11:41:51 -0800
Subject: [GIT PULL] omap fixes for v2.6.38-rc6
Message-ID: <20110228194151.GJ20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

This contains one more timer regression fix, a DPLL rate fix,
and a mailbox NULL pointer fix that would be good to get
in for 2.6.38. The series also removes world-writable flag for
some debugfs entries.

Other than I believe that's it for omap fixes for v2.6.38.

Regards,

Tony


The following changes since commit f5412be599602124d2bdd49947b231dd77c0bf99:

  Linux 2.6.38-rc6 (2011-02-21 17:25:52 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

John Ogness (1):
      OMAP2/3: clock: fix fint calculation for DPLL_FREQSEL

Kevin Hilman (2):
      OMAP2420: mailbox: fix IVA vs DSP IRQ numbering
      OMAP2+: mailbox: fix lookups for multiple mailboxes

Paul Walmsley (1):
      OMAP2+: clocksource: fix crash on boot when !CONFIG_OMAP_32K_TIMER

Santosh Shilimkar (1):
      omap4: prcm: Fix the CPUx clockdomain offsets

Tony Lindgren (1):
      Merge branch 'patches_for_2.6.38rc' of git://git.pwsan.com/linux-2.6 into devel-fixes

Vasiliy Kulikov (3):
      mach-omap2: mux: world-writable debugfs files
      mach-omap2: pm: world-writable debugfs timer files
      mach-omap2: smartreflex: world-writable debugfs voltage files

 arch/arm/mach-omap2/clkt_dpll.c    |    2 +-
 arch/arm/mach-omap2/mailbox.c      |    2 +-
 arch/arm/mach-omap2/mux.c          |    2 +-
 arch/arm/mach-omap2/pm-debug.c     |    8 ++++----
 arch/arm/mach-omap2/prcm_mpu44xx.h |    4 ++--
 arch/arm/mach-omap2/smartreflex.c  |    4 ++--
 arch/arm/mach-omap2/timer-gp.c     |   13 +++++++++++++
 arch/arm/plat-omap/mailbox.c       |   11 +++++++----
 8 files changed, 31 insertions(+), 15 deletions(-)
