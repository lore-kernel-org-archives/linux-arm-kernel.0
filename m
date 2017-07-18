From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Tue, 18 Jul 2017 15:59:53 +0800
Subject: [PATCH v3 0/6] Add HiSilicon SoC uncore Performance Monitoring Unit
 driver
Message-ID: <1500364799-90518-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for HiSilicon SoC uncore PMUs driver. It
includes L3C, Hydra Home Agent (HHA) and DDRC.

Changes in v3:
* rebase to 4.13-rc1
* add dev_err if ioremap fails for PMUs
 
Changes in v2:
* fix kbuild test robot error
* make hisi_uncore_ops static

Shaokun Zhang (6):
  Documentation: perf: hisi: Documentation for HiSilicon SoC PMU driver
  perf: hisi: Add support for HiSilicon SoC uncore PMU driver
  perf: hisi: Add support for HiSilicon SoC L3C PMU driver
  perf: hisi: Add support for HiSilicon SoC HHA PMU driver
  perf: hisi: Add support for HiSilicon SoC DDRC PMU driver
  arm64: MAINTAINERS: hisi: Add HiSilicon SoC PMU support

 Documentation/perf/hisi-pmu.txt               |  51 +++
 MAINTAINERS                                   |   7 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/hisilicon/Makefile               |   1 +
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 437 ++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 453 +++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 556 ++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c      | 411 +++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h      | 116 ++++++
 include/linux/cpuhotplug.h                    |   1 +
 11 files changed, 2041 insertions(+)
 create mode 100644 Documentation/perf/hisi-pmu.txt
 create mode 100644 drivers/perf/hisilicon/Makefile
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

-- 
1.9.1
