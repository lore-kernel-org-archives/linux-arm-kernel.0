From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 16:01:10 +0000
Subject: [RFC PATCH 0/4] ARM: add support for hw-breakpoints [v2]
Message-ID: <1268236874-7877-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of the RFC originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009084.html

Changes from the previous version include:

- Based on 2.6.33
- Removal of self-modifying code to access the debug registers
- Control and value registers now reset during init
- Removal of .name field from struct arch_hw_breakpoint and associated
  symbol resolution [following comments made about patches for PPC].

All comments welcome [the last submission didn't attract any!].

Cc: Frederic Weisbecker <fweisbec@gmail.com>

Will Deacon (4):
  ARM: hw-breakpoint: add mechanism for hooking into prefetch aborts
  ARM: hw-breakpoint: add ARM backend for the hw-breakpoint framework
  ARM: hw-breakpoint: add new ptrace requests for hw-breakpoint
    interaction
  ARM: hw-breakpoint: add HAVE_HW_BREAKPOINT to Kconfig

 arch/arm/Kconfig                     |    1 +
 arch/arm/include/asm/hw_breakpoint.h |  118 ++++++
 arch/arm/include/asm/processor.h     |    4 +
 arch/arm/include/asm/ptrace.h        |    2 +
 arch/arm/include/asm/system.h        |    3 +
 arch/arm/kernel/Makefile             |    1 +
 arch/arm/kernel/hw_breakpoint.c      |  711 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/ptrace.c             |  158 ++++++++
 arch/arm/mm/fault.c                  |   11 +
 9 files changed, 1009 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hw_breakpoint.h
 create mode 100644 arch/arm/kernel/hw_breakpoint.c
