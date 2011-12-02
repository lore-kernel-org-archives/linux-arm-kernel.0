From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Dec 2011 17:02:31 +0000
Subject: [GIT PULL] ARM perf updates for 3.3
Message-ID: <20111202170231.GP5540@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these updates to the ARM perf code for 3.3. The highlights are
probably the CTI stuff (which is in preparation for OMAP4 support coming from
Lei Ming, Benoit and Paul) and the cleanup of the event numbers for ARMv7 so
that they are easier to follow. I was hoping to add Cortex-A7 support but I
haven't got my paws on an FPGA yet.

I've not included my contextidr patch with this pull because it conflicts
quite badly with the LPAE patches. I can rework this for 3.4 later on (I
already have a fixup).

Cheers,

Will


The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk

Ming Lei (2):
      arm: introduce cross trigger interface helpers
      arm: pmu: allow platform specific irq enable/disable handling

Will Deacon (4):
      ARM: perf: clean and update ARMv7 event numbers
      ARM: perf: add support for stalled cycle ABI events
      ARM: perf: remove unused armpmu_get_max_events
      Merge branches 'perf/event-nos', 'perf/updates' and 'perf/omap4' into for-rmk

 arch/arm/include/asm/cti.h          |  179 ++++++++++++++++
 arch/arm/include/asm/perf_event.h   |    3 -
 arch/arm/include/asm/pmu.h          |   15 +-
 arch/arm/kernel/perf_event.c        |   19 +-
 arch/arm/kernel/perf_event_v6.c     |   32 ++--
 arch/arm/kernel/perf_event_v7.c     |  401 +++++++++++++----------------------
 arch/arm/kernel/perf_event_xscale.c |   16 +-
 7 files changed, 379 insertions(+), 286 deletions(-)
 create mode 100644 arch/arm/include/asm/cti.h
