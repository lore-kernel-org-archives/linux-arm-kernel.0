From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Feb 2012 15:58:12 +0000
Subject: [PATCH 0/4] perf IRQ fixes
Message-ID: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is a set of fixes to the IRQ handling for perf-events on
ARM. Thanks to Ming Lei for identifying a couple of the issues addressed
here.

I tested the xscale2 changes on my Gumstix Verdex (PXA270 although the
board isn't actually supported in mainline), the v6 changes on a PB1176
and the v7 changes on a Cortex-A9 vexpress.

I think all of these are candidates for -stable, although it may be too
late for the final cut of 3.3.

All comments welcome,

Will


Will Deacon (4):
  ARM: perf: limit sample_period to half max_period in non-sampling
    mode
  ARM: perf: clear overflow flag when disabling counter on ARMv7 PMU
  ARM: perf: check that we have an event in the PMU IRQ handlers
  ARM: perf: fix overflow handling for xscale2 PMUs

 arch/arm/include/asm/pmu.h          |    2 +-
 arch/arm/kernel/perf_event.c        |   22 +++++++++++-----------
 arch/arm/kernel/perf_event_v6.c     |   22 +++-------------------
 arch/arm/kernel/perf_event_v7.c     |   11 ++++++++++-
 arch/arm/kernel/perf_event_xscale.c |   20 ++++++++++++++++----
 5 files changed, 41 insertions(+), 36 deletions(-)

-- 
1.7.4.1
