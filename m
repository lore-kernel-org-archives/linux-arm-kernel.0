From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 12 Jun 2012 14:02:00 +0200
Subject: [RFC 0/4] ARM: topology: set the capacity of each cores for big.LITTLE
Message-ID: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset creates an arch_scale_freq_power function for ARM, which is used 
to set the relative capacity of each core of a big.LITTLE system. 

Vincent Guittot (4):
  ARM: topology: Add arch_scale_freq_power function
  ARM: topology: factorize the update of sibling masks
  ARM: topology: Update cpu_power according to DT information
  sched: cpu_power: enable ARCH_POWER

 arch/arm/include/asm/topology.h |    2 +
 arch/arm/kernel/topology.c      |  203 +++++++++++++++++++++++++++++++++++----
 kernel/sched/features.h         |    2 +-
 3 files changed, 185 insertions(+), 22 deletions(-)

-- 
1.7.9.5
