From: zsm@chromium.org (Zubin Mithra)
Date: Mon, 18 Jun 2018 08:30:49 -0700
Subject: [RFC v2 0/4] arm: Moving thread_info into task_struct
Message-ID: <20180618153053.186224-1-zsm@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are a set of preparatory patches for moving the thread_info
into task_struct for ARM. The patches that perform that actual move
are not implemented yet.

These patches have only been tested on QEMU using the following boards.
- versatilepb
- vexpress-a9

[v2 changes]
- Add a patch that stores thread_info in sp^

Zubin Mithra (4):
  arm: Store address of thread_info in sp^
  arm: factor out current_stack_pointer
  arm: make cpu a percpu variable
  arm: add refcounting for task stacks

 arch/arm/include/asm/assembler.h     | 27 ++++++++++++++++++++++-----
 arch/arm/include/asm/percpu.h        |  2 ++
 arch/arm/include/asm/smp.h           | 11 ++++++++++-
 arch/arm/include/asm/stack_pointer.h |  9 +++++++++
 arch/arm/include/asm/switch_to.h     | 11 +++++++++++
 arch/arm/include/asm/thread_info.h   | 19 ++++++++++++-------
 arch/arm/kernel/entry-armv.S         |  5 ++++-
 arch/arm/kernel/entry-common.S       |  2 ++
 arch/arm/kernel/head-common.S        |  2 ++
 arch/arm/kernel/head.S               |  1 +
 arch/arm/kernel/process.c            | 21 +++++++++++++++------
 arch/arm/kernel/return_address.c     |  1 +
 arch/arm/kernel/setup.c              |  2 +-
 arch/arm/kernel/smp.c                | 13 +++++++++++--
 arch/arm/kernel/stacktrace.c         |  8 ++++++++
 arch/arm/kernel/topology.c           |  2 ++
 arch/arm/kernel/traps.c              | 13 +++++++++++--
 arch/arm/kernel/unwind.c             |  1 +
 18 files changed, 125 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/include/asm/stack_pointer.h

-- 
2.18.0.rc1.244.gcf134e6275-goog
