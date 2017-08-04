From: nleeder@codeaurora.org (Neil Leeder)
Date: Fri,  4 Aug 2017 15:59:12 -0400
Subject: [PATCH 0/2] arm64 SMMUv3 PMU driver with IORT support
Message-ID: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a driver for the SMMUv3 PMU into the perf framework.
It includes an IORT update to support PM Counter Groups.

IORT has no mechanism for determining device names so PMUs
are named based on their physical address. 

Tested on Qualcomm QDF2400. perf_fuzzer ran for 4+ hours
with no failures.

Neil Leeder (2):
  acpi: arm64: add iort support for PMCG
  perf: add arm64 smmuv3 pmu driver

 drivers/acpi/arm64/iort.c     |  54 +++
 drivers/perf/Kconfig          |   9 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_smmuv3_pmu.c | 823 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h         |   9 +-
 5 files changed, 895 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/arm_smmuv3_pmu.c

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
