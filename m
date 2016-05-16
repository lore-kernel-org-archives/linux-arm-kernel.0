From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 May 2016 18:50:46 +0100
Subject: [GIT PULL] arm64: perf updates for 4.7
Message-ID: <20160516175046.GB22358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 perf updates for 4.7. The main addition
here is support for Broadcom's Vulcan core using the architected ID
registers for discovering supported events.

Cheers,

Will

--->8

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-perf

for you to fetch changes up to 4ba2578fa7b557012b8f59ad7a9284ff15394338:

  arm64: perf: don't expose CHAIN event in sysfs (2016-04-25 15:05:24 +0100)

----------------------------------------------------------------
arm64 perf updates for 4.7

- Support for the PMU in Broadcom's Vulcan CPU

- Dynamic event detection using the PMCEIDn_EL0 ID registers

----------------------------------------------------------------
Ashok Kumar (7):
      Documentation: arm64: pmu: Add Broadcom Vulcan PMU binding
      arm64: dts: Add Broadcom Vulcan PMU in dts
      arm64/perf: Changed events naming as per the ARM ARM
      arm64/perf: Define complete ARMv8 recommended implementation defined events
      arm64/perf: Access pmu register using <read/write>_sys_reg
      arm64/perf: Filter common events based on PMCEIDn_EL0
      arm64/perf: Add Broadcom Vulcan PMU support

Will Deacon (1):
      arm64: perf: don't expose CHAIN event in sysfs

 Documentation/devicetree/bindings/arm/pmu.txt |   3 +-
 arch/arm64/boot/dts/broadcom/vulcan.dtsi      |   2 +-
 arch/arm64/kernel/perf_event.c                | 553 +++++++++++++++++---------
 include/linux/perf/arm_pmu.h                  |   2 +
 4 files changed, 370 insertions(+), 190 deletions(-)
