From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Nov 2010 17:01:21 -0000
Subject: [GIT PULL] ARM: perf: split by architecture
Message-ID: <003201cb8cc2$62c73e80$2855bb80$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I tried to submit these to your patch system but the nature of the final
patch means that it is too large (because it moves code out of perf_event.c
and into the new per-arch files). Please can you pull these changes now that
they have been reviewed on the list?

Thanks,

Will


The following changes since commit 3561d43fd289f590fdae672e5eb831b8d5cf0bf6:
  Linus Torvalds (1):
        Linux 2.6.37-rc3

are available in the git repository at:

  git://linux-arm-org/linux-2.6-wd.git perf-split

Will Deacon (5):
      ARM: perf: consolidate common PMU behaviour
      ARM: perf: avoid exposing internal stop function for v6 PMU
      ARM: perf: add _init() functions to PMUs
      ARM: perf: encode PMU name in arm_pmu structure
      ARM: perf: separate PMU backends into multiple files

 arch/arm/kernel/perf_event.c        | 2448 +----------------------------------
 arch/arm/kernel/perf_event_v6.c     |  672 ++++++++++
 arch/arm/kernel/perf_event_v7.c     |  906 +++++++++++++
 arch/arm/kernel/perf_event_xscale.c |  807 ++++++++++++
 4 files changed, 2419 insertions(+), 2414 deletions(-)
 create mode 100644 arch/arm/kernel/perf_event_v6.c
 create mode 100644 arch/arm/kernel/perf_event_v7.c
 create mode 100644 arch/arm/kernel/perf_event_xscale.c
