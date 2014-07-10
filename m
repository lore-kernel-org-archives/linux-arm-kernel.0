From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jul 2014 11:31:09 +0100
Subject: [GIT PULL] ARM perf updates for 3.17
Message-ID: <20140710103109.GI2449@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please can you pull the following perf updates for 3.17? You will get a
trivial conflict with your MIDR rework, but SFR fixed that up correctly
already in -next [1].

The main changes are:

  - Callchain stability fixes from Jean Pihet
  - Event mapping and PMU name rework from Mark Rutland

The latter is preparatory work for enabling some code re-use with arm64
in the future.

Cheers,

Will

[1] https://lkml.org/lkml/2014/7/1/659

Cc: Jean Pihet <jean.pihet@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>

--->8

The following changes since commit 4c834452aad01531db949414f94f817a86348d59:

  Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/perf

for you to fetch changes up to 4b2974fa6a4a32d390a50e23381a2270a2e0d444:

  ARM: perf: disable the pagefault handler when reading from user space (2014-07-09 15:05:29 +0100)

----------------------------------------------------------------
Jean Pihet (2):
      ARM: perf: Check that current->mm is alive before getting user callchain
      ARM: perf: disable the pagefault handler when reading from user space

Mark Rutland (8):
      arm: perf: move event map macros to pmu.h
      arm: perf: add macros for empty event mappings
      arm: perf: armv7: condense event maps
      arm: perf: armv6: condense event maps
      arm: perf: xscale: condense event maps
      arm: perf: clean up PMU names
      arm: perf: add more specific platform device IDs
      arm: perf: krait: stop using singleton PMU

 arch/arm/include/asm/perf_event.h   |   9 -
 arch/arm/include/asm/pmu.h          |  19 +
 arch/arm/kernel/perf_event.c        |  13 +-
 arch/arm/kernel/perf_event_cpu.c    |  13 +-
 arch/arm/kernel/perf_event_v6.c     | 307 +++---------
 arch/arm/kernel/perf_event_v7.c     | 967 ++++++++----------------------------
 arch/arm/kernel/perf_event_xscale.c | 121 +----
 arch/arm/oprofile/common.c          |  14 +-
 8 files changed, 360 insertions(+), 1103 deletions(-)
