From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 17 Oct 2017 00:02:17 +0530
Subject: [PATCH v9 0/5] Add support for ThunderX2 pmu events using json files
Message-ID: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extending json/jevent framework for parsing arm64 event files.
Adding jevents for ThunderX2 implementation defined PMU events.

v9:
   - Rebased to [3] and resolved conficts in PATCH 1/5 and reworked PATCH 3/5.
   - Added PATCH 5 to fix segmentation fault in perf_pmu__find_map

[3] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

v8:
   - Rename thunderx2 directory to cavium

v7:
   - Addressed some more comments from Will Deacon.

v6 : Addressed comments [1] [2]

[1] https://patchwork.kernel.org/patch/9903099/
[2] https://patchwork.kernel.org/patch/9853899/

v5:
   - Addressed comments from Arnaldo.
   - Rebased to 4.13-rc5

v4:
   - Rebased to 4.13-rc1

v3:
   - Addressed comments from Will Deacon and Jayachandran C.
   - Rebased to 4.12-rc1

v2:
   - Updated as per Mark Rutland's suggestions.
   - Added provision for get_cpuid_str to get cpu id string
     from associated cpus of pmu core device.

v1: Initial patchset.


Ganapatrao Kulkarni (5):
  perf utils: passing pmu as a parameter to function get_cpuid_str
  perf tools arm64: Add support for get_cpuid_str function.
  perf utils: use pmu->is_uncore to detect PMU CORE/UNCORE devices
  perf vendor events arm64: Add ThunderX2 implementation defined pmu
    core events
  perf utils: add check for valid cpuid in function perf_pmu__find_map

 tools/perf/arch/arm64/util/Build                   |  1 +
 tools/perf/arch/arm64/util/header.c                | 65 ++++++++++++++++++++++
 tools/perf/arch/powerpc/util/header.c              |  2 +-
 tools/perf/arch/x86/util/header.c                  |  2 +-
 .../arch/arm64/cavium/thunderx2-imp-def.json       | 62 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 +++++
 tools/perf/util/header.h                           |  3 +-
 tools/perf/util/metricgroup.c                      |  4 +-
 tools/perf/util/pmu.c                              | 39 ++++++++-----
 tools/perf/util/pmu.h                              |  2 +-
 10 files changed, 174 insertions(+), 21 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv

-- 
2.9.4
