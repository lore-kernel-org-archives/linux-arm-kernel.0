From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 18:44:59 -0700
Subject: [GIT PULL 6/6] omap soc changes for v3.13 merge window
In-Reply-To: <pull-1381542299-305003>
Message-ID: <mailman.7.1381542361.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/soc-take2

for you to fetch changes up to d5da94b88efebc375bfcbab6bb0e59a6e8a6571e:

  ARM: OMAP2+: Fix build error for realtime counter init if not enabled (2013-10-11 17:28:04 -0700)

----------------------------------------------------------------
SoC related changes for omaps to support the realtime
counter on newer omaps, and to fail early for omap5 es1.0
SoCs that don't have any support merged for them in the
mainline tree.

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP5: id: Remove ES1.0 support

R Sricharan (1):
      ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ register

Sricharan R (1):
      ARM: OMAP2+: DRA7: realtime_counter: Add ratio registers for 20MHZ sys-clk frequency

Tony Lindgren (1):
      ARM: OMAP2+: Fix build error for realtime counter init if not enabled

 arch/arm/mach-omap2/id.c          |  8 ++++----
 arch/arm/mach-omap2/omap-secure.h |  4 ++++
 arch/arm/mach-omap2/omap-smp.c    |  7 +++++++
 arch/arm/mach-omap2/soc.h         |  2 --
 arch/arm/mach-omap2/timer.c       | 17 +++++++++++++++++
 5 files changed, 32 insertions(+), 6 deletions(-)
