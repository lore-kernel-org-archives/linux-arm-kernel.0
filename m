From: jglauber@cavium.com (Jan Glauber)
Date: Wed, 17 May 2017 10:31:19 +0200
Subject: [PATCH v5 0/3] Cavium ARM64 uncore PMU support
Message-ID: <20170517083122.5050-1-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is another attempt of adding support for some PMU counters on Cavium SOCs.

The major change is that I quit trying to merge the counters as it would
not fit with your requirements [1].

Another big change is that now the EDAC driver for the devices
carrying the PMU counters is upstream. I've added a simple callback
to the EDAC driver which owns the devices, so probing is much simpler now.

The driver still provides common "uncore" functions to avoid
code duplication and support adding more device PMUs (like L2 cache) in
the future.

[1] https://marc.info/?l=linux-arm-kernel&m=147940675216946&w=4

Jan Glauber (3):
  perf: export perf_event_update_userpage()
  perf: cavium: Support memory controller PMU counters
  perf: cavium: Support transmit-link PMU counters

 drivers/edac/thunderx_edac.c    |  19 +-
 drivers/perf/Kconfig            |   8 +
 drivers/perf/Makefile           |   1 +
 drivers/perf/cavium_pmu.c       | 629 ++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h      |   1 +
 include/linux/perf/cavium_pmu.h |  35 +++
 kernel/events/core.c            |   1 +
 7 files changed, 693 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/cavium_pmu.c
 create mode 100644 include/linux/perf/cavium_pmu.h

-- 
2.9.0.rc0.21.g7777322
