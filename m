From: rabin@rab.in (Rabin Vincent)
Date: Sat, 13 Mar 2010 12:19:37 +0530
Subject: [PATCH 00/10] ARM: ftrace: cleanups, Thumb-2, and dynamic ftrace (v2)
Message-ID: <1268462987-8271-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: Fixes as per review comments.  The only code changes are the #error in 0004
and the removal of the #ifdef in 0009.  The rest are comments and commit
message rewording/expansion.

This series contains fixes and improvements to the ARM ftrace support.  It adds
Thumb-2 support and re-implements the dynamic ftrace support.

"ftrace: allow building without frame pointers" and "ftrace: pass KBUILD_CFLAGS
to record_mcount.pl" are non-ARM-specific ftrace patches which are required to
support the ARM functionality.

Cleanups / docs:

  ARM: ftrace: clean up mcount assembly indentation
  ARM: ftrace: document mcount formats

Thumb-2:

  ftrace: allow building without frame pointers
  ARM: ftrace: allow building without frame pointers
  ARM: ftrace: add ENDPROC annotations
  ARM: ftrace: add Thumb-2 support

Dynamic ftrace:

  ftrace: pass KBUILD_CFLAGS to record_mcount.pl
  ARM: ftrace: fix and update dynamic ftrace
  ARM: ftrace: add Thumb-2 support to dynamic ftrace
  ARM: ftrace: enable dynamic ftrace

 Makefile                       |    7 ++
 arch/arm/Kconfig               |    2 +
 arch/arm/Kconfig.debug         |    5 +
 arch/arm/include/asm/ftrace.h  |   20 ++++-
 arch/arm/kernel/armksyms.c     |    2 +
 arch/arm/kernel/entry-common.S |  178 +++++++++++++++++++++++++++-----------
 arch/arm/kernel/ftrace.c       |  188 +++++++++++++++++++++++++++++----------
 kernel/trace/Kconfig           |    2 +-
 scripts/Makefile.build         |    3 +-
 scripts/recordmcount.pl        |    2 +
 10 files changed, 307 insertions(+), 102 deletions(-)
