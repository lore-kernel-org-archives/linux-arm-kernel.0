From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 17:54:12 +0000
Subject: [PATCH v6 0/5] kexec fixes and soft restart code
Message-ID: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 6 of the patches originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053252.html
v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062305.html
v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/071909.html

This patch series is slightly smaller than the last post because it now
depends on the idmap work I have posted separately here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073033.html

As before, this is also dependent on Russell's reset work (available in
his reset branch).

Thanks,

Will


Will Deacon (5):
  ARM: lib: add call_with_stack function for safely changing stack
  ARM: reset: implement soft_restart for jumping to a physical address
  ARM: soft_restart: disable the outer L2 when the last CPU is going
    down
  ARM: stop: execute platform callback from cpu_stop code
  ARM: kexec: use soft_restart for branching to the reboot buffer

 arch/arm/Kconfig                |    2 +-
 arch/arm/kernel/machine_kexec.c |   15 ++--------
 arch/arm/kernel/process.c       |   55 ++++++++++++++++++++++++++++++--------
 arch/arm/kernel/smp.c           |    4 +++
 arch/arm/lib/Makefile           |    3 +-
 arch/arm/lib/call_with_stack.S  |   44 +++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/lib/call_with_stack.S

-- 
1.7.4.1
