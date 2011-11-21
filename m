From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Nov 2011 17:45:00 +0000
Subject: [GIT PULL] ARM perf fixes for 3.2
Message-ID: <20111121174500.GJ20611@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these perf fixes for 3.2. Without them, modules trying to use
the PMU will not compile (I accidently dropped an EXPORT_SYMBOL) and, more
seriously, perf can be made to dereference NULL if the user tries to
schedule an event group.

Thanks to Tixy and Pawel for reporting the issues.

Cheers,

Will


The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:

  Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk

Will Deacon (3):
      ARM: PMU: re-export release_pmu symbol to modules
      ARM: PMU: remove pmu_init declaration
      ARM: perf: initialise used_mask for fake PMU during validation

 arch/arm/include/asm/pmu.h   |   10 ----------
 arch/arm/kernel/perf_event.c |    8 +++++++-
 arch/arm/kernel/pmu.c        |    1 +
 3 files changed, 8 insertions(+), 11 deletions(-)
