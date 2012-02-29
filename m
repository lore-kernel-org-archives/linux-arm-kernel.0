From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Wed, 29 Feb 2012 07:34:40 -0700
Subject: [PATCH v2 0/3] ARM support for syscall tracing
In-Reply-To: <4F44FF58.3060907@mentor.com>
References: <4F44FF58.3060907@mentor.com>
Message-ID: <4F4E3780.4060904@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rework of Steven Walter's syscall tracing patches first
posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074454.html

I've rebased the patches against the current mainline master branch, as well
as implemented several changes based on feedback from Will Deacon and
Russel King.

v2: - Tested on EABI and OABI.
    - Removed an instance of the ?: operator in syscall_set_return_value()
    - Moved #define of NR_syscalls to syscall.h
    - Changed the test of NR_syscalls vs __NR_syscalls in entry-common.S
      to .ifne

Wade Farnsworth (3):
  ARM: add support for the generic syscall.h interface
  ARM: add TRACEHOOK support
  ARM: support syscall tracing

 arch/arm/Kconfig                   |    2 +
 arch/arm/include/asm/ptrace.h      |    5 ++
 arch/arm/include/asm/syscall.h     |   97 ++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/thread_info.h |    2 +
 arch/arm/include/asm/unistd.h      |    8 +++
 arch/arm/kernel/entry-common.S     |   16 +++++-
 arch/arm/kernel/ptrace.c           |   34 +++++++------
 arch/arm/kernel/signal.c           |    2 +
 8 files changed, 149 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/include/asm/syscall.h
