From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jun 2010 10:36:01 +0100
Subject: [PATCH 0/2] add perf-probe support on ARM
Message-ID: <1277285763-16213-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perf-probe uses the KProbe events tracer to place and monitor probes
on the running Kernel.

This patch series adds both Kernel and tool support for this feature
on ARM.

Patches based on 2.6.35-rc3 [although perf record is currently broken
on all architectures for probe tracepoints. These patches also apply
cleanly to -tip/master where perf record works properly.]

Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jpihet@mvista.com>

Will Deacon (2):
  ARM: Add kprobe-based event tracer
  ARM: perf probe: Add ARM DWARF register number mappings

 arch/arm/Kconfig                      |    1 +
 arch/arm/include/asm/ptrace.h         |   36 ++++++++++++
 arch/arm/kernel/ptrace.c              |   96 +++++++++++++++++++++++++++++++++
 tools/perf/arch/arm/Makefile          |    4 ++
 tools/perf/arch/arm/util/dwarf-regs.c |   64 ++++++++++++++++++++++
 5 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 tools/perf/arch/arm/Makefile
 create mode 100644 tools/perf/arch/arm/util/dwarf-regs.c
