From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Mon, 30 Sep 2013 15:14:08 +0530
Subject: [PATCH v2 0/3] AArch64: KGDB support
Message-ID: <1380534251-4464-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Based on the step-handler and break-handler hooks patch from
Sandeepa (Patch 1), KGDB debugging support is added for EL1
debug in AArch64 mode. Any updates that come for Patch 1 from
Sandeepa will be rebased in next version

With first patch,register layout is updated to be inline with GDB tool.
Basic GDB connection, break point set/clear and info commands
are supported except step/next debugging

With second patch, step/next debugging support is added, where in
pc is updated to point to the instruction to be stepped and
stopped.

v2:
 - Moved break instruction encoding to debug-monitors.h file
 - Fixed endianess of compile break instruction encoding
 - Updated I/O buffer sizes
 - Updated register buffer size
 - Remove changes to debug_exception handler in entry.S for
 - ELR update and step debugging with update pc instead of ELR
 - Rebased against AArch64 upstream kernel

v1:
 - Initial patch-set

Tested with Aarch64 GDB tool chain on simulator

Sandeepa Prabhu (1):
  AArch64: Add single-step and breakpoint handler hooks

Vijaya Kumar K (2):
  AArch64: KGDB: Add Basic KGDB support
  AArch64: KGDB: Add step debugging support

 arch/arm64/include/asm/debug-monitors.h |   30 +++
 arch/arm64/include/asm/kgdb.h           |   81 ++++++++
 arch/arm64/kernel/Makefile              |    1 +
 arch/arm64/kernel/debug-monitors.c      |   95 ++++++++-
 arch/arm64/kernel/entry.S               |    6 +-
 arch/arm64/kernel/kgdb.c                |  341 +++++++++++++++++++++++++++++++
 6 files changed, 550 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/kgdb.h
 create mode 100644 arch/arm64/kernel/kgdb.c

-- 
1.7.9.5
