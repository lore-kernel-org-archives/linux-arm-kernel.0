From: Ganapatrao.Kulkarni@cavium.com (Kulkarni, Ganapatrao)
Date: Thu, 25 Oct 2018 05:59:15 +0000
Subject: [PATCH v7 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Message-ID: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v7:
	Incorporated review comments [3].
	Modified driver as loadable module.
	Updated Documentation with Event description.
	Removed per-channel(no SMC calls) sampling implementation(
	Since DMC and L3C channels are interleave, we have decided to
	sample channel zero and prorate it to account for a Device).

[3] https://patchwork.kernel.org/patch/10479203/

v6:
	Rebased to 4.18-rc1
	Updated with comments from John Garry[3]

[3] https://lkml.org/lkml/2018/5/17/408

v5:
	Incorporated review comments from Mark Rutland[2]
v4:
	Incorporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html
[2] https://lkml.org/lkml/2018/4/26/376

v3:
	Fixed warning reported by kbuild robot

v2:
	Rebased to 4.12-rc1
	Removed Arch VULCAN dependency.
	Update SMC call parameters as per latest firmware.

v1:
	Initial patch

Ganapatrao Kulkarni (2):
  perf, uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt | 106 ++++
 drivers/perf/Kconfig                 |   9 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 867 +++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 5 files changed, 984 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

-- 
2.18.0
