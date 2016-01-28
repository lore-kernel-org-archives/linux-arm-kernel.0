From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 28 Jan 2016 15:54:58 +0100
Subject: [PATCH v2 0/5] Cavium ThunderX PMU support
Message-ID: <cover.1453992560.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark & Will,

I'm resending the arm64 PMU patches. The only difference to the first
version is that I dropped the x on thunder in order to be consistent
with the existing device tree name.

Thanks,
Jan

Jan Glauber (5):
  arm64/perf: Rename Cortex A57 events
  arm64/perf: Add Cavium ThunderX PMU support
  arm64: dts: Add Cavium ThunderX specific PMU
  arm64/perf: Enable PMCR long cycle counter bit
  arm64/perf: Extend event mask for ARMv8.1

 Documentation/devicetree/bindings/arm/pmu.txt |   1 +
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  |   5 +
 arch/arm64/kernel/perf_event.c                | 145 ++++++++++++++++++++------
 drivers/perf/arm_pmu.c                        |   5 +-
 include/linux/perf/arm_pmu.h                  |   4 +-
 5 files changed, 125 insertions(+), 35 deletions(-)

-- 
1.9.1
