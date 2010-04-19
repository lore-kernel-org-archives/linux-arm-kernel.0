From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Apr 2010 17:42:35 +0100
Subject: [PATCH 0/6] ARM: oprofile: use perf-events framework as backend [v4]
Message-ID: <1271695361-7121-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 4 [hopefully the final iteration!] of the patchset originally
posted here:

V1: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/010476.html
V2: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011126.html
V3: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/012871.html

The only change since V3 is that the previous changes to the generic
perf-events code have been moved into the ARM backend. This places the whole
patchset under arch/arm/.

I've not received any feedback for version 3, so unless I receive any objections
to this version, I'll submit it to the patch system this week.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jpihet@mvista.com>

Will Deacon (6):
  ARM: perf-events: use numeric ID to identify PMU
  ARM: perf-events: add support for xscale PMUs
  ARM: perf-events: allow modules to query the number of hardware
    counters
  ARM: oprofile: use perf-events framework as backend
  ARM: oprofile: remove old files and update KConfig
  ARM: oprofile: convert from sysdev to platform device

 arch/arm/Kconfig                        |   26 +-
 arch/arm/include/asm/perf_event.h       |   17 +
 arch/arm/kernel/perf_event.c            |  876 ++++++++++++++++++++++++++++++-
 arch/arm/oprofile/Makefile              |    7 +-
 arch/arm/oprofile/backtrace.c           |   83 ---
 arch/arm/oprofile/common.c              |  375 +++++++++++---
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
 16 files changed, 1190 insertions(+), 1870 deletions(-)
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
