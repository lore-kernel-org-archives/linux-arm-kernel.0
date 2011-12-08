From: will.deacon@arm.com (Will Deacon)
Date: Thu,  8 Dec 2011 19:03:17 +0000
Subject: [PATCH v8 0/6] kexec fixes and soft restart code
Message-ID: <1323371001-4036-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 8 of the patches originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053252.html
v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062305.html
v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/071909.html
v6: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073054.html
v7: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074338.html

There are a few small changes since v7:

 - Fixed a warning in the stack declaration from an implicit u64* -> u32* cast
 - Rebased onto rmk/devel-stable, which now includes my idmap patches
 - Merged in the outer_disable patch with the soft_restart patch as it
   didn't warrant a separate commit.

I'm pretty happy with these patches, but I appreciate there is already a lot
queued for 3.3. Russell - would you rather I held fire on these for the time
being (the downside being that soft reboot is broken for a bit longer)?

Cheers,

Will


Will Deacon (4):
  ARM: lib: add call_with_stack function for safely changing stack
  ARM: reset: implement soft_restart for jumping to a physical address
  ARM: stop: execute platform callback from cpu_stop code
  ARM: kexec: use soft_restart for branching to the reboot buffer

 arch/arm/Kconfig                |    2 +-
 arch/arm/kernel/machine_kexec.c |   15 ++---------
 arch/arm/kernel/process.c       |   50 +++++++++++++++++++++++++++++++-------
 arch/arm/kernel/smp.c           |    4 +++
 arch/arm/lib/Makefile           |    3 +-
 arch/arm/lib/call_with_stack.S  |   44 ++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/lib/call_with_stack.S

-- 
1.7.4.1
