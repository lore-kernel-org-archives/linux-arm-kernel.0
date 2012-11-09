From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Nov 2012 15:05:43 +0000
Subject: [GIT PULL] perf updates for 3.8
Message-ID: <1352473543-18319-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This patch series is largely a continuation of the ongoing perf work
to support multi-cluster, but there are also a couple of other random
patches for OMAP (Acked by Tony) and future-proofing for KVM from Marc.

Cheers,

Will


The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/updates

Jon Hunter (1):
      ARM: PMU: fix runtime PM enable

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
 arch/arm/kernel/perf_event.c        |   85 ++++++++----
 arch/arm/kernel/perf_event_cpu.c    |   74 +++++++----
 arch/arm/kernel/perf_event_v6.c     |  126 +++++++++---------
 arch/arm/kernel/perf_event_v7.c     |  246 ++++++++++++++++------------------
 arch/arm/kernel/perf_event_xscale.c |  157 ++++++++++++-----------
 arch/arm/mach-omap2/pmu.c           |    2 -
 8 files changed, 385 insertions(+), 338 deletions(-)
