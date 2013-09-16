From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Mon, 16 Sep 2013 14:25:48 +0530
Subject: [RFC PATCH 0/2] Aarch64: KGDB: kernel debugging support
Message-ID: <1379321750-907-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Based on the step-handler and break-handler hooks patch
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/189510.html
KGDB debugging support is added for EL1 debug in Aarch64 mode

With first patch,register layout is updated to be inline with GDB tool.
Basic GDB connection, break point set/clear and info commands
are supported except step/next debugging

With second patch, step/next debugging support is added, where in
ELR_EL1 is updated to point to the instruction to be stepped and
stopped.

kernel exception handler exit macro in entry.S is update to
retain ELR value written by KGDB.

Tested with Aarch64 GDB tool chain on simulator

Vijaya Kumar K (2):
  Aarch64: KGDB: Add Basic KGDB support
  Aarch64: KGDB: Add Step debugging support

 arch/arm64/include/asm/debug-monitors.h |    3 +
 arch/arm64/include/asm/kgdb.h           |   61 ++++++
 arch/arm64/kernel/Makefile              |    1 +
 arch/arm64/kernel/debug-monitors.c      |   15 ++
 arch/arm64/kernel/entry.S               |    9 +-
 arch/arm64/kernel/kgdb.c                |  323 +++++++++++++++++++++++++++++++
 6 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kgdb.h
 create mode 100644 arch/arm64/kernel/kgdb.c

-- 
1.7.9.5
