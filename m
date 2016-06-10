From: ttnguyen@apm.com (Tai Nguyen)
Date: Thu,  9 Jun 2016 18:24:48 -0700
Subject: [PATCH v3 0/4] perf: Add APM X-Gene SoC Performance Monitoring Unit
 driver
Message-ID: <1465521892-31420-1-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to the X-Gene ARM CPU performance monitoring unit (PMU), there
are PMU for the SoC system devices such as L3 cache(s), I/O bridge(s),
memory controller bridges and memory. These PMU devices are loosely
architected to follow the same model as the PMU for ARM cores.

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---

v3:
 * Remove index property use in PMU device sub nodes

v2:
 * Use bitmask for event asignned counter mask pmu_dev->cntr_assign_mask
 * Remove unnecessary spinlocks in perf add/del operations
 * Remove unnecessary condition checks
 * Enforce CPU assignment to one CPU for perf operarations
 * Set the task_ctx_nr to perf_invalid_context for perf driver
 * Remove irrelevant pt_rregs
 * Change perf sysfs attributes to be fixed instead of dynamic
 * Fix checking for an ACPI companion device instead of EFI enable
 * Add documentation for config/config1 fields format and perf tool example

---
Tai Nguyen (4):
  MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
  Documentation: Add documentation for APM X-Gene SoC PMU DTS binding
  perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver
  arm64: dts: apm: Add APM X-Gene SoC PMU DTS entries

 .../devicetree/bindings/perf/apm-xgene-pmu.txt     |  112 ++
 Documentation/perf/xgene-pmu.txt                   |   48 +
 MAINTAINERS                                        |    8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   58 +
 drivers/perf/Kconfig                               |    7 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/xgene_pmu.c                           | 1427 ++++++++++++++++++++
 7 files changed, 1661 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 create mode 100644 Documentation/perf/xgene-pmu.txt
 create mode 100644 drivers/perf/xgene_pmu.c

-- 
1.9.1
