From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Jan 2016 12:30:19 +0000
Subject: [GIT PULL] arm64: perf updates for 4.5
Message-ID: <20160112123018.GF15737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

In the past, I have funnelled perf updates through the respective
architecture trees, but now that the arm/arm64 perf driver has been
largely consolidated under drivers/perf/, it makes more sense to send a
separate pull, particularly as I'm listed as maintainer for all the
files involved. I offered the branch to arm-soc, but Arnd suggested that
I just send it to you directly.

So, here is the arm/arm64 perf queue for 4.5. The main features are
described in the tag, but the most useful change is from Drew, which
advertises our architected event mapping in sysfs so that the perf tool
is a lot more user friendly and no longer requires the use of magic hex
constants for profiling common events.

Please pull,

Will

--->8

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-perf

for you to fetch changes up to 5d7ee87708d4d86fcc32afc9552d05f7625d303d:

  arm64: perf: add support for Cortex-A72 (2015-12-22 14:45:35 +0000)

----------------------------------------------------------------
arm[64] perf updates for 4.5:

- Support for the CPU PMU in Cortex-A72

- Add sysfs entries to describe the architected events and their
  mappings for PMUv{1-3}

----------------------------------------------------------------
Drew Richardson (4):
      arm: perf: Convert event enums to #defines
      arm: perf: Add event descriptions
      arm64: perf: Convert event enums to #defines
      arm64: perf: Add event descriptions

Geert Uytterhoeven (1):
      arm64: perf: Correct Cortex-A53/A57 compatible values

Lorenzo Pieralisi (1):
      arm64: kernel: enforce pmuserenr_el0 initialization and restore

Mark Rutland (1):
      drivers/perf: kill armpmu_register

Will Deacon (3):
      ARM: perf: add format entry to describe event -> config mapping
      arm64: perf: add format entry to describe event -> config mapping
      arm64: perf: add support for Cortex-A72

 Documentation/devicetree/bindings/arm/pmu.txt |   5 +-
 arch/arm/kernel/perf_event_v7.c               | 321 ++++++++++++++++++--------
 arch/arm64/kernel/perf_event.c                | 263 ++++++++++++++++-----
 arch/arm64/mm/proc.S                          |   2 +
 drivers/perf/arm_pmu.c                        |  15 +-
 include/linux/perf/arm_pmu.h                  |   2 -
 6 files changed, 440 insertions(+), 168 deletions(-)
