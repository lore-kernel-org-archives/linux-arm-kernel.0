From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Aug 2011 15:56:22 +0100
Subject: [GIT PULL] Fixes for 3.1
Message-ID: <20110812145621.GC13586@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following fixes for 3.1. The main changes are fixing up
broken nomenclature in pmu.c [which became inconsistent during the merge
window] and fixing I-cache policy detection on v6.

As agreed, I'm sending realview changes via you rather than Arnd.

Thanks,

Will


The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:
  Linus Torvalds (1):
        Linux 3.1-rc1

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git 3.1-fixes-for-rmk

Florian Fainelli (1):
      ARM: fix perf build with uclibc toolchains

Mark Rutland (2):
      ARM: perf: fix prototype of release_pmu
      ARM: perf: make name of arm_pmu_type consistent

Will Deacon (3):
      ARM: realview: ensure visibility of writes during reset
      ARM: twd: register clockevents device before enabling PPI
      ARM: cache: detect VIPT aliasing I-cache on ARMv6

 arch/arm/include/asm/pmu.h                   |   10 +++++-----
 arch/arm/kernel/pmu.c                        |   26 +++++++++++++-------------
 arch/arm/kernel/setup.c                      |   15 ++++++++-------
 arch/arm/kernel/smp_twd.c                    |    4 ++--
 arch/arm/mach-realview/include/mach/system.h |    1 +
 tools/perf/arch/arm/util/dwarf-regs.c        |    3 +++
 6 files changed, 32 insertions(+), 27 deletions(-)
