From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:33:37 +0100
Subject: [PATCH 0/7] ARM: perf: updates for 3.8
Message-ID: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are the ARM perf patches I currently plan to send via Russell for
3.8. It's mostly continued cleanup and more work on the multi-cluster
support but there's also an exciting patch from Marc in anticipation of
KVM.

All feedback welcome,

Will


Marc Zyngier (1):
  ARM: perf: add guest vs host discrimination

Mark Rutland (1):
  ARM: perf: register cpu_notifier at driver init

Sudeep KarkadaNagesha (3):
  ARM: perf: allocate CPU PMU dynamically at probe time
  ARM: perf: consistently use struct perf_event in arm_pmu functions
  ARM: perf: check ARMv7 counter validity on a per-pmu basis

Will Deacon (2):
  ARM: perf: return NOTIFY_DONE from cpu notifier when no available PMU
  ARM: perf: consistently use arm_pmu->name for PMU name

 arch/arm/include/asm/perf_event.h   |    5 +
 arch/arm/include/asm/pmu.h          |   28 ++---
 arch/arm/kernel/perf_event.c        |   84 ++++++++----
 arch/arm/kernel/perf_event_cpu.c    |   74 +++++++----
 arch/arm/kernel/perf_event_v6.c     |  126 +++++++++---------
 arch/arm/kernel/perf_event_v7.c     |  246 ++++++++++++++++------------------
 arch/arm/kernel/perf_event_xscale.c |  157 ++++++++++++-----------
 7 files changed, 384 insertions(+), 336 deletions(-)

-- 
1.7.4.1
