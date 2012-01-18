From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2012 16:14:49 +0000
Subject: [PATCH v2 0/3] Convert remaining platforms to common sched_clock()
Message-ID: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only two platforms are left with their own sched_clock() implementation.
This patch series converts them, leading in both cases to some cleanup.

The last patch makes the sched_clock framework mandatory, so people
don't try to add another implementation.

* From the initial revision
- Add a patch killing the HAVE_SCHED_CLOCK option.

Marc Zyngier (3):
  ARM: davinci: convert to common sched_clock() implementation
  ARM: prima2: convert to common sched_clock() implementation
  ARM: Make the sched_clock framework mandatory

 arch/arm/Kconfig                |   16 ----------------
 arch/arm/kernel/Makefile        |    3 +--
 arch/arm/kernel/time.c          |    2 --
 arch/arm/mach-davinci/time.c    |   24 +++++++-----------------
 arch/arm/mach-prima2/timer.c    |   21 +++++++--------------
 arch/arm/plat-nomadik/Kconfig   |    1 -
 arch/arm/plat-versatile/Kconfig |    1 -
 7 files changed, 15 insertions(+), 53 deletions(-)

-- 
1.7.7.1
