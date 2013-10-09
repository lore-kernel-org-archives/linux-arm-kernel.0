From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Oct 2013 18:08:19 +0100
Subject: [GIT PULL] perf updates for 3.13
Message-ID: <20131009170819.GI8378@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following perf updates for 3.13. The most noticeable change
is adding user unwinding support, which relies on libunwind in the perf tool
for ARM, but there is also a group validation cleanup following on from
fixes made in 3.11.

The perf tools maintainers are happy for these changes to go via this route:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/203077.html

Cheers,

Will

--->8

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/perf

for you to fetch changes up to 2dfcb802d6bd54a2353678c6434846d94b058f2c:

  ARM: perf: fix group validation for mixed software and hardware groups (2013-10-09 14:33:07 +0100)

----------------------------------------------------------------
Jean Pihet (2):
      perf tools: Check libunwind for availability of dwarf parsing feature
      perf: parse the .debug_frame section in case .eh_frame is not present

Will Deacon (3):
      ARM: perf: add support for perf registers API
      ARM: perf: wire up perf_regs and unwind support for ARM
      ARM: perf: fix group validation for mixed software and hardware groups

 arch/arm/Kconfig                        |  2 +
 arch/arm/include/uapi/asm/Kbuild        |  1 +
 arch/arm/include/uapi/asm/perf_regs.h   | 23 ++++++++++
 arch/arm/kernel/Makefile                |  1 +
 arch/arm/kernel/perf_event.c            |  3 +-
 arch/arm/kernel/perf_regs.c             | 30 +++++++++++++
 tools/perf/arch/arm/Makefile            |  3 ++
 tools/perf/arch/arm/include/perf_regs.h | 54 ++++++++++++++++++++++++
 tools/perf/arch/arm/util/unwind.c       | 48 +++++++++++++++++++++
 tools/perf/config/Makefile              | 13 ++++--
 tools/perf/config/feature-tests.mak     | 21 ++++++++-
 tools/perf/util/unwind.c                | 75 ++++++++++++++++++++++++++-------
 12 files changed, 252 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/include/uapi/asm/perf_regs.h
 create mode 100644 arch/arm/kernel/perf_regs.c
 create mode 100644 tools/perf/arch/arm/include/perf_regs.h
 create mode 100644 tools/perf/arch/arm/util/unwind.c
