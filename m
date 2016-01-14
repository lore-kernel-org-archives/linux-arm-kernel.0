From: jan.glauber@gmail.com (Jan Glauber)
Date: Thu, 14 Jan 2016 13:55:40 +0100
Subject: [RFC PATCH 0/5] Cavium ThunderX PMU support
Message-ID: <cover.1452766568.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will & Mark,

please have a look at these patches for perf PMU support. The Cavium
PMU stuff should be pretty generic but the long cycle counter bit
will change all ARMv8 PMUs and needs careful review.

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
