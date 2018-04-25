From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Wed, 25 Apr 2018 14:30:45 +0530
Subject: [PATCH v4 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Message-ID: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v4:
     -Incroporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html

v3:
     - fixed warning reported by kbuild robot

v2:
     - rebased to 4.12-rc1
     - Removed Arch VULCAN dependency.
     - update SMC call parameters as per latest firmware.

v1:
     -Initial patch

Ganapatrao Kulkarni (2):
  perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt |  66 +++
 drivers/perf/Kconfig                 |   8 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 958 +++++++++++++++++++++++++++++++++++
 4 files changed, 1033 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

-- 
2.9.4
