From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Nov 2018 22:41:57 +0000
Subject: [PATCH 0/6] arm64: ftrace fixes/cleanup
Message-ID: <20181115224203.24847-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches clean up some issues I spotted while looking at Torsten's
FTRACE_WITH_REGS patches. I've pushed these to my arm64/ftrace-cleanup [1]
branch, based on my export cleanup patches.

Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace-cleanup

Mark Rutland (6):
  linkage: add generic GLOBAL() macro
  arm64: ftrace: use GLOBAL()
  arm64: ftrace: enable graph FP test
  arm64: ftrace: don't adjust the LR value
  arm64: ftrace: remove return_regs macros
  arm64: ftrace: always pass instrumented pc in x0

 arch/arm64/include/asm/ftrace.h  |  1 +
 arch/arm64/kernel/entry-ftrace.S | 51 +++++++++++++++++-----------------------
 arch/arm64/kernel/ftrace.c       |  2 +-
 include/linux/linkage.h          |  6 +++++
 4 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.11.0
