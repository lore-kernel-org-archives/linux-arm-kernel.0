From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon,  4 Jan 2010 10:48:37 +0000
Subject: ARM perf events support v4
Message-ID: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the fourth revision of ARM performance counter support. This adds
support for software performance events on all ARM platforms and hardware
support for v6 processors. There is a generic PMU framework to allow for v7
and later to be added in the future.

Jamie Iles (5):
      arm: provide a mechanism to reserve performance counters
      arm/oprofile: reserve the PMU when starting
      arm: use the spinlocked, generic atomic64 support
      arm: enable support for software perf events
      arm/perfevents: implement perf event support for ARMv6

 arch/arm/Kconfig                        |   16 +
 arch/arm/include/asm/atomic.h           |    4 +
 arch/arm/include/asm/perf_event.h       |   38 +
 arch/arm/include/asm/pmu.h              |   74 ++
 arch/arm/kernel/Makefile                |    2 +
 arch/arm/kernel/perf_event.c            | 1338 +++++++++++++++++++++++++++++++
 arch/arm/kernel/pmu.c                   |  107 +++
 arch/arm/mm/fault.c                     |    7 +
 arch/arm/oprofile/op_model_arm11_core.c |    4 +-
 arch/arm/oprofile/op_model_arm11_core.h |    4 +-
 arch/arm/oprofile/op_model_mpcore.c     |   42 +-
 arch/arm/oprofile/op_model_v6.c         |   30 +-
 arch/arm/oprofile/op_model_v7.c         |   30 +-
 arch/arm/oprofile/op_model_v7.h         |    4 +-
 arch/arm/oprofile/op_model_xscale.c     |   35 +-
 15 files changed, 1671 insertions(+), 64 deletions(-)

Jamie
