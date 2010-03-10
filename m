From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 10:41:24 +0000
Subject: [PATCH 0/6] ARM: oprofile: use perf-events framework as backend [v2]
Message-ID: <1268217690-29712-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of the patchset originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/010476.html

The only changes from the original code concern the PMU ID scheme and name
resolution. This is now handled using an enum of IDs rather than a list of
#defines.

Patches taken against 2.6.33.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jpihet@mvista.com>

Will Deacon (6):
  ARM: perf-events: add Realview PMU IRQs to pmu.c
  ARM: perf-events: use numeric ID to identify PMU
  ARM: perf-events: add support for xscale PMUs
  perf-events: export enable/disable event symbols to kernel modules
  ARM: oprofile: use perf-events framework as backend
  ARM: oprofile: remove old files and update KConfig

 arch/arm/Kconfig                        |   26 +-
 arch/arm/include/asm/perf_event.h       |   14 +
 arch/arm/kernel/perf_event.c            |  862 ++++++++++++++++++++++++++++++-
 arch/arm/kernel/pmu.c                   |   14 +
 arch/arm/oprofile/Makefile              |    7 +-
 arch/arm/oprofile/backtrace.c           |   83 ---
 arch/arm/oprofile/common.c              |  356 +++++++++++--
 arch/arm/oprofile/op_arm_model.h        |   35 --
 arch/arm/oprofile/op_counter.h          |   27 -
 arch/arm/oprofile/op_model_arm11_core.c |  162 ------
 arch/arm/oprofile/op_model_arm11_core.h |   45 --
 arch/arm/oprofile/op_model_mpcore.c     |  306 -----------
 arch/arm/oprofile/op_model_mpcore.h     |   61 ---
 arch/arm/oprofile/op_model_v6.c         |   78 ---
 arch/arm/oprofile/op_model_v7.c         |  415 ---------------
 arch/arm/oprofile/op_model_v7.h         |  103 ----
 arch/arm/oprofile/op_model_xscale.c     |  444 ----------------
 include/linux/perf_event.h              |    1 +
 kernel/perf_event.c                     |    8 +
 19 files changed, 1194 insertions(+), 1853 deletions(-)
 delete mode 100644 arch/arm/oprofile/backtrace.c
 delete mode 100644 arch/arm/oprofile/op_arm_model.h
 delete mode 100644 arch/arm/oprofile/op_counter.h
 delete mode 100644 arch/arm/oprofile/op_model_arm11_core.c
 delete mode 100644 arch/arm/oprofile/op_model_arm11_core.h
 delete mode 100644 arch/arm/oprofile/op_model_mpcore.c
 delete mode 100644 arch/arm/oprofile/op_model_mpcore.h
 delete mode 100644 arch/arm/oprofile/op_model_v6.c
 delete mode 100644 arch/arm/oprofile/op_model_v7.c
 delete mode 100644 arch/arm/oprofile/op_model_v7.h
 delete mode 100644 arch/arm/oprofile/op_model_xscale.c
