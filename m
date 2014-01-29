From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 Jan 2014 12:45:07 -0500
Subject: [PATCH v2 0/6] setting the table for integration of cpuidle with the
 scheduler
Message-ID: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As everyone should know by now, we want to integrate the cpuidle
governor with the scheduler for a more efficient idling of CPUs.
In order to help the transition, this small patch series moves the
existing interaction with cpuidle from architecture code to generic
core code.  The ARM, PPC, SH and X86 architectures are concerned.
No functional change should have occurred yet.

@peterz: Are you willing to pick up those patches?

Change from v1:

- dropped removal of arch_cpu_idle_prepare()


 arch/arm/kernel/process.c                       | 16 +++------
 arch/powerpc/platforms/pseries/processor_idle.c |  5 +++
 arch/powerpc/platforms/pseries/setup.c          | 34 ++++++++-----------
 arch/sh/kernel/idle.c                           |  4 +--
 arch/x86/kernel/process.c                       |  5 +--
 kernel/Makefile                                 |  1 -
 kernel/cpu/Makefile                             |  1 -
 kernel/sched/Makefile                           |  2 +-
 kernel/{cpu => sched}/idle.c                    |  4 ++-
 9 files changed, 30 insertions(+), 42 deletions(-)


Nicolas
