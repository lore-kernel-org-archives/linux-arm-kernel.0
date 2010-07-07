From: will.deacon@arm.com (Will Deacon)
Date: Wed,  7 Jul 2010 17:22:56 +0100
Subject: [PATCH 0/4] ARM: add support for hw-breakpoints [v4]
Message-ID: <1278519780-13317-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 4 of the patches originally posted at:

v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009084.html
v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011170.html
v3.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017680.html

Changes from v3 include:
	- Based on 2.6.35-rc3
	- Support for unaligned addresses
	- Numerous bug fixes
	- Tested with GDB, for which the testsuite passes

GDB patches have been posted here:

http://sourceware.org/ml/gdb-patches/2010-07/msg00110.html

I'd like to get these patches applied now that I'm confident that
they function correctly, so please give them a go.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>
Cc: Matthew Gretton-Dann <matthew.gretton-dann@arm.com>

Will Deacon (4):
  ARM: hw-breakpoint: add mechanism for hooking into prefetch aborts
  ARM: hw-breakpoint: add ARM backend for the hw-breakpoint framework
  ARM: hw-breakpoint: add new ptrace requests for hw-breakpoint
    interaction
  ARM: hw-breakpoint: add HAVE_HW_BREAKPOINT to Kconfig

 arch/arm/Kconfig                     |    1 +
 arch/arm/include/asm/hw_breakpoint.h |  117 ++++++
 arch/arm/include/asm/processor.h     |    4 +
 arch/arm/include/asm/ptrace.h        |    2 +
 arch/arm/include/asm/system.h        |    3 +
 arch/arm/kernel/Makefile             |    1 +
 arch/arm/kernel/hw_breakpoint.c      |  760 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/ptrace.c             |  223 ++++++++++
 arch/arm/mm/fault.c                  |   11 +
 9 files changed, 1122 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hw_breakpoint.h
 create mode 100644 arch/arm/kernel/hw_breakpoint.c
