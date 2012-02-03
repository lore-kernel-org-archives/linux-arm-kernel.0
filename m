From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Feb 2012 11:58:58 +0000
Subject: [PULL] Convert remaining platforms to common sched_clock()
Message-ID: <1328270338-30744-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Could you please pull the following branch, which converts the last two
platforms to the common sched_clock() framework. It's been acked by
the relevant maintainers.

The last patch makes the sched_clock framework mandatory, so people
don't try to add another implementation.

Thanks,

	M.

The following changes since commit dcf81c1af839b77b44404453ecae6e5ac5a75f05:

  Merge branch 'amba' into for-armsoc (2012-01-26 19:59:44 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git sched_clock-for-rmk

Marc Zyngier (3):
      ARM: davinci: convert to common sched_clock() implementation
      ARM: prima2: convert to common sched_clock() implementation
      ARM: Make the sched_clock framework mandatory

Sekhar Nori (1):
      ARM: davinci: time.c: group related header files together

 arch/arm/Kconfig                |   16 ----------------
 arch/arm/kernel/Makefile        |    5 ++---
 arch/arm/kernel/time.c          |    2 --
 arch/arm/mach-davinci/time.c    |   28 ++++++++++------------------
 arch/arm/mach-prima2/timer.c    |   21 +++++++--------------
 arch/arm/plat-nomadik/Kconfig   |    1 -
 arch/arm/plat-versatile/Kconfig |    1 -
 7 files changed, 19 insertions(+), 55 deletions(-)
