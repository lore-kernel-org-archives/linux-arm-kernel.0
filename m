From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Jun 2012 16:58:03 +0100
Subject: [PATCH v3 0/4] syscall_trace fixes and cleanups
Message-ID: <1339775887-32103-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 3 of the patches originally posted here:

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/097748.html
  v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/103281.html

The only changes from v2 are that the series is now based on -rc2 and
I've added Al and Eric to CC. Functionally it is identical.

All feedback welcome,

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
