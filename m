From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jun 2010 15:59:53 +0100
Subject: [RFC PATCH 0/4] ARM: add support for hw-breakpoints [v3]
Message-ID: <1276181997-20677-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 3 of the RFC patches originally posted at:

v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009084.html
v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011170.html

Changes from v2 include:
	- Based on 2.6.35-rc2
	- Updated to use new hw-breakpoint API features
	- Addressed some comments from Frederic on LKML
	- Complete redesign of the ptrace interface so that it
	  follows the ARM ARM (v7) register structure more closely.

Unfortunately, I've only managed to compile-test this and check that the
resulting image boots. The main reasons for posting are (a) to support
current GDB development and (b) to attract comments on the code.

All comments welcome.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>

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
 arch/arm/kernel/hw_breakpoint.c      |  734 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/ptrace.c             |  196 +++++++++
 arch/arm/mm/fault.c                  |   11 +
 9 files changed, 1069 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hw_breakpoint.h
 create mode 100644 arch/arm/kernel/hw_breakpoint.c
