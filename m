From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jan 2013 18:03:47 +0000
Subject: [GIT PULL] perf updates for 3.9
Message-ID: <20130123180347.GG26811@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Arnd, Olof,

Please can you pull these perf updates for 3.9? They should go via both
rmk and arm-soc as they are a dependency for kvm and some Tegra SCU
stuff. I'll keep this branch stable, so others can base against it if
they like.

Cheers,

Will

--->8

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/perf

for you to fetch changes up to 9dcbf466559f6f2f55d60eb5a1bbebc8e694b52a:

  ARM: perf: simplify __hw_perf_event_init err handling (2013-01-18 16:54:30 +0000)

----------------------------------------------------------------
Christoffer Dall (2):
      ARM: Define CPU part numbers and implementors
      ARM: Use implementor and part defines from cputype.h

Mark Rutland (3):
      ARM: perf: handle armpmu_register failing
      ARM: perf: remove unnecessary checks for idx < 0
      ARM: perf: simplify __hw_perf_event_init err handling

Will Deacon (2):
      ARM: perf: remove redundant NULL check on cpu_pmu
      ARM: perf: don't pretend to support counting of L1I writes

 arch/arm/include/asm/cputype.h      | 33 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/perf_event.c        | 16 +++-------------
 arch/arm/kernel/perf_event_cpu.c    | 51 +++++++++++++++++++++++++++------------------------
 arch/arm/kernel/perf_event_v6.c     |  4 ++--
 arch/arm/kernel/perf_event_v7.c     | 18 +++++++++---------
 arch/arm/kernel/perf_event_xscale.c |  2 +-
 6 files changed, 75 insertions(+), 49 deletions(-)
