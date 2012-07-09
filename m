From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon,  9 Jul 2012 11:27:01 +0200
Subject: [PATCH v4 0/5] ARM: topology: set the capacity of each cores for
 big.LITTLE
Message-ID: <1341826026-6504-1-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset creates an arch_scale_freq_power function for ARM, which is used 
to set the relative capacity of each core of a big.LITTLE system. It also removes
the broken power estimation of x86.

Modification since v3:
 - Add comments
 - Add optimization for SMP system
 - Ensure that capacity of a CPU will be at most 1

Modification since v2:
 - set_power_scale function becomes static
 - Rework loop in update_siblings_masks
 - Remove useless code in parse_dt_topology

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

 arch/arm/kernel/topology.c   |  239 ++++++++++++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/Makefile |    2 +-
 arch/x86/kernel/cpu/sched.c  |   55 ----------
 kernel/sched/features.h      |    2 +-
 4 files changed, 219 insertions(+), 79 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/sched.c

-- 
1.7.9.5
