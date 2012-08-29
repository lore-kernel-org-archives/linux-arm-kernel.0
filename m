From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Aug 2012 22:10:34 +0100
Subject: [GIT PULL] ARM perf updates for 3.7
Message-ID: <20120829211034.GA13222@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I appreciate that perf changes don't usually go via arm-soc, but in this
case I'm touching a bunch of platforms (albeit in a fairly mechanical way)
so it would be great if you could pull this into a branch for 3.7. Jon can
then use it as a base for his OMAP PMU patches and I think that ST and
Samsung may also have patches that depend on this lot.

The changes outside of platform code are restricted to perf files and the
whole series has been in -next since -rc1.

Cheers,

Will

---

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-perf-3.7

for you to fetch changes up to 051f1b13144dd8553d5a5104dde94c7263ae3ba7:

  ARM: perf: move irq registration into pmu implementation (2012-08-23 11:35:52 +0100)

----------------------------------------------------------------
Bunch of perf updates for the ARM backend that pave the way for
big.LITTLE support in the future. The separation of CPU and PMU code
is also the start of being able to move some of this stuff under
drivers/.

----------------------------------------------------------------
Jon Hunter (1):
      ARM: PMU: Add runtime PM Support

Sudeep KarkadaNagesha (2):
      ARM: pmu: remove arm_pmu_type enumeration
      ARM: perf: move irq registration into pmu implementation

Will Deacon (6):
      ARM: perf: add devicetree bindings for 11MPcore, A5, A7 and A15 PMUs
      ARM: pmu: remove unused reservation mechanism
      ARM: perf: remove mysterious compiler barrier
      ARM: perf: probe devicetree in preference to current CPU
      ARM: perf: prepare for moving CPU PMU code into separate file
      ARM: perf: move CPU-specific PMU handling code into separate file

 Documentation/devicetree/bindings/arm/pmu.txt |   4 +
 MAINTAINERS                                   |   1 -
 arch/arm/Kconfig                              |   8 +-
 arch/arm/include/asm/perf_event.h             |   9 +-
 arch/arm/include/asm/pmu.h                    |  77 ++----
 arch/arm/kernel/Makefile                      |   3 +-
 arch/arm/kernel/perf_event.c                  | 347 ++++----------------------
 arch/arm/kernel/perf_event_cpu.c              | 295 ++++++++++++++++++++++
 arch/arm/kernel/perf_event_v6.c               |  12 +-
 arch/arm/kernel/perf_event_v7.c               |  32 +--
 arch/arm/kernel/perf_event_xscale.c           |  10 +-
 arch/arm/kernel/pmu.c                         |  36 ---
 arch/arm/mach-bcmring/arch.c                  |   3 +-
 arch/arm/mach-omap2/devices.c                 |   3 +-
 arch/arm/mach-pxa/devices.c                   |   3 +-
 arch/arm/mach-realview/realview_eb.c          |   3 +-
 arch/arm/mach-realview/realview_pb1176.c      |   3 +-
 arch/arm/mach-realview/realview_pb11mp.c      |   3 +-
 arch/arm/mach-realview/realview_pba8.c        |   3 +-
 arch/arm/mach-realview/realview_pbx.c         |   3 +-
 arch/arm/mach-tegra/devices.c                 |   3 +-
 arch/arm/mach-ux500/cpu-db8500.c              |   3 +-
 arch/arm/mach-vexpress/ct-ca9x4.c             |   3 +-
 arch/arm/plat-iop/pmu.c                       |   3 +-
 arch/arm/plat-samsung/devs.c                  |   3 +-
 25 files changed, 424 insertions(+), 449 deletions(-)
 create mode 100644 arch/arm/kernel/perf_event_cpu.c
 delete mode 100644 arch/arm/kernel/pmu.c
