From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 23 Oct 2017 12:37:43 +0100
Subject: [RFC PATCH 0/1] arm64/sve: ABI change: Zero SVE regs on syscall entry
Message-ID: <1508758664-24186-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes an ABI change, relative on the SVE v3 series [1].  See
the patch for details.

I may fold it into the series later, but for the benefit of reviewers
I'm posting this separately for now.

[1] [PATCH v3 00/28] ARM Scalable Vector Extension (SVE)
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/535717.html

Dave Martin (1):
  arm64/sve: ABI change: Zero SVE regs on syscall entry

 arch/arm64/include/asm/fpsimd.h      |  1 -
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/entry.S            | 19 +++++++++++++++
 arch/arm64/kernel/fpsimd.c           | 47 +++---------------------------------
 arch/arm64/kernel/process.c          | 29 +++++++++++++---------
 arch/arm64/kernel/signal.c           |  6 -----
 6 files changed, 41 insertions(+), 62 deletions(-)

-- 
2.1.4
