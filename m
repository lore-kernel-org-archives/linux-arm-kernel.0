From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Mar 2016 16:16:40 +0000
Subject: [GIT PULL] arm64: perf updates for 4.6
Message-ID: <20160321161639.GM23397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I have another mixed bag of ARM-related perf patches here. It's about
25% CPU and 75% interconnect, but with drivers/bus/ languishing without
an obvious maintainer or tree, Olof and I agreed to keep all of these
PMU patches together. I suspect a whole load of code from drivers/bus/arm-*
can be moved under drivers/perf/, so that's on the radar for the future.

In the meantime, please pull. Headlines in the tag.

Will

--->8

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-perf

for you to fetch changes up to 357b565d5d52b2dc2a51390eb8f887a9caa8597f:

  drivers/perf: arm_pmu: avoid NULL dereference when not using devicetree (2016-03-21 11:36:17 +0000)

----------------------------------------------------------------
arm[64] perf updates for 4.6:

- Initial support for ARMv8.1 CPU PMUs

- Support for the CPU PMU in Cavium ThunderX

- CPU PMU support for systems running 32-bit Linux in secure mode

- Support for the system PMU in ARM CCI-550 (Cache Coherent Interconnect)

----------------------------------------------------------------
Andrzej Hajda (1):
      arm-cci: fix handling cpumask_any_but return value

Dirk Behme (1):
      drivers/perf: arm_pmu: make info messages more verbose

Jan Glauber (5):
      arm64: perf: Rename Cortex A57 events
      arm64/perf: Add Cavium ThunderX PMU support
      arm64: perf: Enable PMCR long cycle counter bit
      arm64: perf: Extend event mask for ARMv8.1
      arm64: dts: Add Cavium ThunderX specific PMU

Lorenzo Pieralisi (1):
      drivers/perf: arm_pmu: implement CPU_PM notifier

Mark Rutland (1):
      arm-cci: simplify sysfs attr handling

Martin Fuzzey (1):
      ARM: perf: Set ARMv7 SDER SUNIDEN bit

Suzuki K Poulose (11):
      arm-cci: Group writes to counter
      arm-cci: Refactor CCI PMU enable/disable methods
      arm-cci: Delay PMU counter writes to pmu::pmu_enable
      arm-cci: write_counter: Remove redundant check
      arm-cci: Get the status of a counter
      arm-cci: Add routines to save/restore all counters
      arm-cci: Add helper to enable PMU without synchornising counters
      arm-cci: Provide hook for writing to PMU counters
      arm-cci: CCI-500: Work around PMU counter writes
      arm-cci500: Rearrange PMU driver for code sharing with CCI-550 PMU
      arm-cci: CoreLink CCI-550 PMU driver

Will Deacon (5):
      arm-cci: make private functions static
      arm-cci: don't return value from void function
      arm-cci: remove unused variable
      arm64: perf: Extend ARMV8_EVTYPE_MASK to include PMCR.LC
      drivers/perf: arm_pmu: avoid NULL dereference when not using devicetree

 Documentation/devicetree/bindings/arm/cci.txt |   2 +
 Documentation/devicetree/bindings/arm/pmu.txt |  11 +
 arch/arm/kernel/perf_event_v7.c               |  13 +-
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  |   5 +
 arch/arm64/kernel/perf_event.c                | 122 ++++-
 drivers/bus/Kconfig                           |  10 +-
 drivers/bus/arm-cci.c                         | 621 ++++++++++++++++++--------
 drivers/perf/arm_pmu.c                        | 109 ++++-
 include/linux/perf/arm_pmu.h                  |   2 +
 9 files changed, 667 insertions(+), 228 deletions(-)
