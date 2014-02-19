From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Feb 2014 15:14:40 -0800
Subject: [PATCH v4 0/4] ARM: zynq: cpufreq support
Message-ID: <1392851684-29950-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

another iteration of this series. The patches are the same as in v3, but
the series shrank a bit. I rebased this series on tip/timers/core, hence
the two patches for the clockevent core fell out, since Thomas already
applied those.
Additionally I removed the patch 'clocksource/cadence_ttc: Use only one
counter'. Thomas brought up some questions regarding that patch which
need to be investigated. Since it is not required for the rest of this
series, I just dropped it for now.

	Thanks,
	S?ren

Soren Brinkmann (4):
  clocksource/cadence_ttc: Call clockevents_update_freq() with IRQs
    enabled
  clocksource/cadence_ttc: Overhaul clocksource frequency adjustment
  arm: zynq: Don't use arm_global_timer with cpufreq
  arm: zynq: Add support for cpufreq

 arch/arm/boot/dts/zynq-7000.dtsi        |   6 ++
 arch/arm/mach-zynq/Kconfig              |   4 +-
 arch/arm/mach-zynq/common.c             |   3 +
 drivers/clocksource/cadence_ttc_timer.c | 121 +++++++++++++++++++++++---------
 4 files changed, 98 insertions(+), 36 deletions(-)

-- 
1.9.0.1.g4196000
