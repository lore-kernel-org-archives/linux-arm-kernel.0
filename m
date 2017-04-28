From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Fri, 28 Apr 2017 10:23:43 +0530
Subject: [PATCH v2 0/4] Add support for ThunderX2 pmu events using json files
Message-ID: <1493355227-31492-1-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extending json/jevent framework for parsing arm64 event files.
Adding jevents for ThunderX2 implementation defined PMU events.

v2:
   - Updated as per Mark Rutland's suggestions.
   - added provision for get_cpuid_str to get cpu id string
     from associated cpus of pmu core device.

v1: Initial patchset.

Ganapatrao Kulkarni (4):
  perf utils: passing pmu as a parameter to function get_cpuid_str
  perf tools arm64: Add support for get_cpuid_str function.
  perf utils: Add helper function is_pmu_core to detect PMU CORE devices
  perf vendor events arm64: Add implementation defined pmu core events
    of ThunderX2

 tools/perf/arch/arm64/util/Build                   |  1 +
 tools/perf/arch/arm64/util/header.c                | 41 ++++++++++++++
 tools/perf/arch/powerpc/util/header.c              |  3 +-
 tools/perf/arch/x86/util/header.c                  |  4 +-
 tools/perf/pmu-events/arch/arm64/mapfile.csv       | 14 +++++
 .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
 tools/perf/util/header.h                           |  3 +-
 tools/perf/util/pmu.c                              | 54 ++++++++++++++++---
 8 files changed, 171 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json

-- 
1.8.1.4
