From: sheetals@codeaurora.org (Sheetal Sahasrabudhe)
Date: Mon,  7 Mar 2011 16:46:44 -0500
Subject: [PATCH v2 0/3] ARM: Add Scorpion/ScorpionMP support to perf and
	Oprofile
Message-ID: <1299534404-25346-1-git-send-email-sheetals@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the following features:
It adds support for Qualcomm Scorpion and ScorpionMP processors to perfevents
and Oprofile.
It adds PMU support for Scorpion and ScorpionMP.
It also updates PMU IRQ identifiers for various Scorpion and ScorpionMP targets.

Sheetal Sahasrabudhe (3):
  msm: Add support for Scorpion and ScorpionMP PMU
  [ARM] perfevents: Add support for Scorpion performance monitors
  [ARM] Oprofile: Add Qualcomm Scorpion and ScorpionMP CPU type

 arch/arm/include/asm/perf_event.h          |    2 +
 arch/arm/kernel/perf_event.c               |   11 +
 arch/arm/kernel/perf_event_msm.c           |  665 ++++++++++++++++++++++++++++
 arch/arm/mach-msm/Makefile                 |    2 +
 arch/arm/mach-msm/include/mach/irqs-7x30.h |    2 +-
 arch/arm/mach-msm/include/mach/irqs-8960.h |    2 +-
 arch/arm/mach-msm/include/mach/irqs-8x50.h |    2 +-
 arch/arm/mach-msm/include/mach/irqs-8x60.h |    2 +-
 arch/arm/mach-msm/pmu.c                    |   35 ++
 arch/arm/oprofile/common.c                 |    4 +
 10 files changed, 723 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/kernel/perf_event_msm.c
 create mode 100644 arch/arm/mach-msm/pmu.c

-- 
1.7.4.1

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
