From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2011 11:15:53 +0100
Subject: [PATCH 0/3] Updates to ARM PMU event numbers
Message-ID: <1317377756-5986-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These three patches update the ARM PMU event numbers so that:

* The two new ABI events are supported on ARM (frontend/backend stalls).

* The ARMv7 PMU events are generally tidied up and made consistent
  between PMUs.

* The HW_CACHE events on Cortex-A9 are routed to more sane event
  definitions. I'd like to get this into the stable tress, so it exists
  as a separate patch.

Note that the generalised events are just an approximation, so although
we don't always provide a direct correspondence in hardware, we aim to
use an event that will at least exhibit statistically equivalent results.

These are taken again rmk/devel-stable, although the A9 fix will apply
against -rc8 and I plan to push it as a fix.

Feedback welcome,

Will


Will Deacon (3):
  ARM: perf: fix HW_CACHE_* events on Cortex-A9
  ARM: perf: clean and update ARMv7 event numbers
  ARM: perf: add support for stalled cycle ABI events

 arch/arm/kernel/perf_event_v6.c     |   32 ++--
 arch/arm/kernel/perf_event_v7.c     |  401 +++++++++++++----------------------
 arch/arm/kernel/perf_event_xscale.c |   16 +-
 3 files changed, 179 insertions(+), 270 deletions(-)
