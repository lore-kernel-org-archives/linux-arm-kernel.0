From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 19 Jun 2012 10:28:51 +0200
Subject: [PATCH v2 0/5] ARM: topology: set the capacity of each cores for
 big.LITTLE
Message-ID: <1340094536-20873-1-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset creates an arch_scale_freq_power function for ARM, which is used 
to set the relative capacity of each core of a big.LITTLE system. It also removes
the broken power estimation of x86.

Modification since v1:
 - Add and update explanation about the use of the table and the range of the value 
 - Remove the use of NR_CPUS and use nr_cpu_ids instead
 - Remove broken power estimation of x86

Peter Zijlstra (1):
  sched, x86: Remove broken power estimation

Vincent Guittot (4):
  ARM: topology: Add arch_scale_freq_power function
  ARM: topology: factorize the update of sibling masks
  ARM: topology: Update cpu_power according to DT information
  sched: cpu_power: enable ARCH_POWER

 arch/arm/include/asm/topology.h |    2 +
 arch/arm/kernel/topology.c      |  210 +++++++++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/Makefile    |    2 +-
 arch/x86/kernel/cpu/sched.c     |   55 ----------
 kernel/sched/features.h         |    2 +-
 5 files changed, 193 insertions(+), 78 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/sched.c

-- 
1.7.9.5
