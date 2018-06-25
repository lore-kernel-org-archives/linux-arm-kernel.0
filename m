From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jun 2018 18:54:42 +0100
Subject: [PATCH 0/3] Support rseq on arm64
Message-ID: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch wires up rseq for native and compat tasks under arm64. Both
have been tested with the selftests and they pass successfully on my Seattle
box.

Cheers,

Will

--->8

Will Deacon (3):
  arm64: rseq: Implement backend rseq calls and select HAVE_RSEQ
  asm-generic: unistd.h: Wire up sys_rseq
  rseq/selftests: Add support for arm64

 arch/arm64/Kconfig                        |   1 +
 arch/arm64/include/asm/unistd.h           |   2 +-
 arch/arm64/include/asm/unistd32.h         |   2 +
 arch/arm64/kernel/entry.S                 |   2 +
 arch/arm64/kernel/ptrace.c                |   2 +
 arch/arm64/kernel/signal.c                |   3 +
 include/uapi/asm-generic/unistd.h         |   4 +-
 tools/testing/selftests/rseq/param_test.c |  20 +
 tools/testing/selftests/rseq/rseq-arm64.h | 594 ++++++++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 10 files changed, 630 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64.h

-- 
2.1.4
