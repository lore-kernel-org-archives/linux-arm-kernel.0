From: jeremy.linton@arm.com (Jeremy Linton)
Date: Sun, 13 Mar 2016 18:23:14 -0500
Subject: [RFC 0/4 v3] arm64/perf: Add ACPI support
Message-ID: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set expands upon the patches published by Mark Salter to clean up
a few of the previous review comments, as well as add support for A72's, and
big/little configurations.

I've been testing this patch in concert with the ACPI/PCIe and ACPI/GICv3
patches. It works well on seattle/juno, but there appears to be a problem with
at least one platform using PPIs (which is questionable as ACPI defines the pmu
interrupt as a GSI). I said a couple weeks ago I would post it, so here it is.

Jeremy Linton (1):
  arm64: pmu: add A72 cpu type, support multiple PMU types

Mark Salter (3):
  arm: pmu: Fix non-devicetree probing
  arm64: pmu: add fallback probe table
  arm64: pmu: Add support for probing with ACPI

 arch/arm64/include/asm/cputype.h |   1 +
 arch/arm64/kernel/perf_event.c   |  11 +-
 arch/arm64/kernel/smp.c          |   5 +
 drivers/perf/Kconfig             |   4 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/arm_pmu.c           |  54 ++++++++--
 drivers/perf/arm_pmu_acpi.c      | 212 +++++++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h     |  10 ++
 8 files changed, 287 insertions(+), 11 deletions(-)
 create mode 100644 drivers/perf/arm_pmu_acpi.c

-- 
2.4.3
