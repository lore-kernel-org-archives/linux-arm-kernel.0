From: panand@redhat.com (Pratyush Anand)
Date: Wed, 12 Oct 2016 11:28:02 +0530
Subject: [PATCH 0/4] ARM64: More flexible HW watchpoint
Message-ID: <cover.1476251587.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we do not support all the byte select option provided by ARM64
specs for a HW watchpoint.

This patch set will help user to instrument a watchpoint with all possible
byte select options.

Pratyush Anand (4):
  hw_breakpoint: Allow watchpoint of length 3,5,6 and 7
  arm64: Allow hw watchpoint at varied offset from base address
  arm64: Allow hw watchpoint of length 3,5,6 and 7
  selftests: arm64: add test for unaligned watchpoint address handling

 arch/arm64/include/asm/hw_breakpoint.h             |   6 +-
 arch/arm64/kernel/hw_breakpoint.c                  |  79 ++++++--
 arch/arm64/kernel/ptrace.c                         |   5 +-
 include/uapi/linux/hw_breakpoint.h                 |   4 +
 tools/include/uapi/linux/hw_breakpoint.h           |   4 +
 tools/testing/selftests/breakpoints/Makefile       |   5 +-
 .../selftests/breakpoints/breakpoint_test_arm64.c  | 223 +++++++++++++++++++++
 7 files changed, 300 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c

-- 
2.7.4
