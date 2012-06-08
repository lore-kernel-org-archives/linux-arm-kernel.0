From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Jun 2012 16:12:17 +0100
Subject: [PATCH v2 0/4] syscall_trace fixes and cleanups
Message-ID: <1339168341-29850-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the patches originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/097748.html

The only changes are that (a) two of the original patches (fixes) have
been now been merged into mainline and (b) the remaining patches in the
series are now rebased onto -rc1, which includes Al's work on the signal
handling / syscall restarting path.

All comments welcome,

Will


Will Deacon (4):
  audit: arm: only allow syscall auditing for pure EABI userspace
  ARM: entry: don't bother with syscall tracing on ret_from_fork path
  ARM: audit: move syscall auditing until after ptrace SIGTRAP handling
  ARM: ptrace: provide separate functions for tracing syscall
    {entry,exit}

 arch/arm/kernel/entry-common.S |   20 +++++-------------
 arch/arm/kernel/ptrace.c       |   42 ++++++++++++++++++++++++++++-----------
 init/Kconfig                   |    2 +-
 3 files changed, 37 insertions(+), 27 deletions(-)

-- 
1.7.4.1
