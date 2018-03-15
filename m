From: zsm@chromium.org (Zubin Mithra)
Date: Thu, 15 Mar 2018 17:08:56 +0000
Subject: [RFC 0/3] ARM: thread_info to task_struct
Message-ID: <20180315170859.93893-1-zsm@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are a set of preparatory patches for moving the thread_info into
the task_struct for ARM. The patches that perform the actual move are
not implemented yet. A patch to make a register(such as sp_usr) point to
thread_info will likely be required, eventually.

Zubin Mithra (3):
  arm: factor out current_stack_pointer
  arm: make cpu a percpu variable
  arm: add refcounting for task stacks

 arch/arm/include/asm/cputype.h       |  3 +++
 arch/arm/include/asm/percpu.h        |  2 ++
 arch/arm/include/asm/smp.h           |  3 ++-
 arch/arm/include/asm/stack_pointer.h |  9 +++++++++
 arch/arm/include/asm/thread_info.h   |  6 +-----
 arch/arm/kernel/process.c            | 21 +++++++++++++++------
 arch/arm/kernel/return_address.c     |  1 +
 arch/arm/kernel/setup.c              |  2 +-
 arch/arm/kernel/smp.c                |  5 +++--
 arch/arm/kernel/stacktrace.c         |  8 ++++++++
 arch/arm/kernel/topology.c           |  5 +++++
 arch/arm/kernel/traps.c              |  5 +++++
 arch/arm/kernel/unwind.c             |  1 +
 13 files changed, 56 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/include/asm/stack_pointer.h

-- 
2.16.2.804.g6dcf76e118-goog
