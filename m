From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 9 Oct 2013 15:11:52 +0530
Subject: [PATCH 0/1] ARM64/ftrace: ftrace support on ARM64
Message-ID: <1381311713-20088-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support for ftrace on ARM64.

This code is compiled with the toolchain patched with profiling(-pg)
support patch from
http://gcc.gnu.org/viewcvs/gcc?view=revision&revision=203028.

Tested for function trace, dynamic function trace,
function graph trace and function graph with 
dynamic trace on simulator.

Note:
Make sure your host machine has below macros(atleast)
defined in file /usr/include/elf.h

#define EM_AARCH64      183             /* ARM64 */
#define R_AARCH64_ABS64                 257


Ganapatrao Kulkarni (1):
  ARM64/ftrace: ftrace support on ARM64.

 arch/arm64/Kconfig                  |   5 +
 arch/arm64/include/asm/ftrace.h     |  85 ++++++++++++++++
 arch/arm64/include/asm/stacktrace.h |   1 +
 arch/arm64/kernel/Makefile          |  10 +-
 arch/arm64/kernel/arm64ksyms.c      |   5 +
 arch/arm64/kernel/entry.S           | 159 +++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c          | 194 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/insn.c            |  47 +++++++++
 arch/arm64/kernel/insn.h            |  44 ++++++++
 arch/arm64/kernel/return_address.c  |  71 +++++++++++++
 scripts/recordmcount.c              |   4 +
 scripts/recordmcount.h              |   3 +-
 scripts/recordmcount.pl             |   6 ++
 13 files changed, 632 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/ftrace.h
 create mode 100644 arch/arm64/kernel/ftrace.c
 create mode 100644 arch/arm64/kernel/insn.c
 create mode 100644 arch/arm64/kernel/insn.h
 create mode 100644 arch/arm64/kernel/return_address.c

-- 
1.8.1.4
