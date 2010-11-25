From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Nov 2010 17:08:15 +0000
Subject: [PATCH 0/4] ARM: hw_breakpoint: fixes and improvements
Message-ID: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series contains a number of fixes and improvements to the
hw_breakpoint implementation for ARM. A quick summary:

* Support for cores that use the OS lock for debug register save/restore
  out of reset.

* A vastly simplified alignment model to match the v7 architecture.
  Breakpoints must be the same length as an instruction and be aligned
  to the same boundary. Watchpoints can be 1, 2, 4 or 8 bytes long and
  aligned to the appropriate datasize (byte, half-word, word, double-word).

* Minor style fix in ptrace.c

All feedback welcome!

Will Deacon (4):
  ARM: hw_breakpoint: ensure OS lock is clear before writing to debug
    registers
  ARM: hw_breakpoint: reset control registers in hotplug path
  ARM: hw_breakpoint: correct and simplify alignment fixup code
  ARM: ptrace: fix style issue with hw_breakpoint interface

 arch/arm/kernel/hw_breakpoint.c |   99 ++++++++++++++++++++++++++------------
 arch/arm/kernel/ptrace.c        |    4 +-
 2 files changed, 70 insertions(+), 33 deletions(-)
