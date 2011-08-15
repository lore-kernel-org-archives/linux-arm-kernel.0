From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:41:52 +0100
Subject: [PATCH v2 0/5] ARM: hw_breakpoint: updates for 3.2
Message-ID: <1313430117-3439-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the patch series originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060330.html

Changes since v1 include:

  * We no longer pretend to support the v7 memory-mapped interface
  * Swapped patch 4 and patch 5
  * Based on -rc2

I'd appreciate any testing with this lot applied (even if it's just boot
testing with CONFIG_HAVE_HW_BREAKPOINT enabled).

Thanks,

Will


Will Deacon (5):
  ARM: hw_breakpoint: add initial Cortex-A15 (debug v7.1) support
  ARM: hw_breakpoint: reserve one breakpoint for watchpoint stepping
  ARM: hw_breakpoint: add support for multiple watchpoints
  ARM: hw_breakpoint: trap undef instruction exceptions in
    reset_ctrl_regs
  ARM: hw_breakpoint: reduce the number of WARN_ONCE invocations

 arch/arm/include/asm/hw_breakpoint.h |    2 +
 arch/arm/kernel/hw_breakpoint.c      |  270 +++++++++++++++++++++-------------
 2 files changed, 167 insertions(+), 105 deletions(-)
