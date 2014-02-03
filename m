From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  3 Feb 2014 14:34:30 -0800
Subject: [PATCH v3 0/7] ARM: zynq: cpufreq support
Message-ID: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the merge window is over and ARM is also booting again. So, time to
restart the discussion on this series.
I rebased the series on 3.14-rc1 which removed some of the patches of
the original submission due to them already having been merged.
Other than that, I didn't do many changes compared to the patches that
have been sent out in early December. Changelogs are included with the
patches.

	Thanks,
	S?ren

Soren Brinkmann (7):
  time: Serialize calls to 'clockevents_update_freq' in the timing core
  time: clockevents: Adjust timer interval when frequency changes
  clocksource/cadence_ttc: Call clockevents_update_freq() with IRQs
    enabled
  clocksource/cadence_ttc: Overhaul clocksource frequency adjustment
  clocksource/cadence_ttc: Use only one counter
  arm: zynq: Don't use arm_global_timer with cpufreq
  arm: zynq: Add support for cpufreq

 arch/arm/boot/dts/zynq-7000.dtsi        |   6 +
 arch/arm/mach-zynq/Kconfig              |   4 +-
 arch/arm/mach-zynq/common.c             |   3 +
 drivers/clocksource/cadence_ttc_timer.c | 213 ++++++++++++++++++--------------
 kernel/time/clockevents.c               |  32 +++--
 kernel/time/tick-broadcast.c            |  25 +++-
 kernel/time/tick-internal.h             |   4 +
 7 files changed, 177 insertions(+), 110 deletions(-)

-- 
1.8.5.3
