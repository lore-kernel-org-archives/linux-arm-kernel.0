From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 May 2012 18:42:54 +0100
Subject: [PATCH 0/6] syscall_trace fixes and cleanups
Message-ID: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This series makes a number of fixes and cleanups to the system call
tracing code on ARM, as well as fixing the interactions with audit.

The first two patches should probably go into -stable whilst the rest
can wait for later. Note that this will conflict horribly with the
tracehook code added recently (sitting in -next) and also with the
additional tracehook patch sitting in the patch system (7375/1).

I'd like to get the two stable patches in ASAP and then help with the
conflict resolution for the merge window (although other ideas welcome).
I can rebase the rest of the series as required.

I lightly tested the audit stuff and gave strace a decent run tracing
through forks.

All comments welcome,

Will


Will Deacon (6):
  ARM: audit: fix treatment of saved ip register during syscall tracing
  ARM: audit: use only AUDIT_ARCH_ARM regardless of endianness
  audit: arm: only allow syscall auditing for pure EABI userspace
  ARM: entry: don't bother with syscall tracing on ret_from_fork path
  ARM: audit: move syscall auditing until after ptrace SIGTRAP handling
  ARM: ptrace: provide separate functions for tracing syscall
    {entry,exit}

 arch/arm/kernel/entry-common.S |   20 +++++-----------
 arch/arm/kernel/ptrace.c       |   49 +++++++++++++++++++++++----------------
 init/Kconfig                   |    2 +-
 3 files changed, 36 insertions(+), 35 deletions(-)

-- 
1.7.4.1
