From: Dave.Martin@arm.com (Dave Martin)
Date: Fri,  1 Jun 2018 11:10:12 +0100
Subject: [PATCH v6 0/2] arm64: signal: Report signal frame size to userspace
 via auxv
Message-ID: <1527847814-22829-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for telling userspace the size of the signal
frame via a new AT_MINSIGSTKSZ entry in the aux vector.

This is an update to [1].  An omitted AT_MINSIGSTKSZ is now replaced
with an AT_IGNORE entry instead of being collapsed out of the auxv
entirely.

See individual patches for the delta.

[1] [PATCH v5 0/2] arm64: signal: Report signal frame size to userspace via auxv
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580974.html


Dave Martin (2):
  arm64/sve: Thin out initialisation sanity-checks for sve_max_vl
  arm64: signal: Report signal frame size to userspace via auxv

 arch/arm64/include/asm/elf.h         | 13 +++++++++
 arch/arm64/include/asm/processor.h   |  5 ++++
 arch/arm64/include/uapi/asm/auxvec.h |  3 ++-
 arch/arm64/kernel/cpufeature.c       |  1 +
 arch/arm64/kernel/fpsimd.c           | 17 +++---------
 arch/arm64/kernel/ptrace.c           |  3 ---
 arch/arm64/kernel/signal.c           | 52 +++++++++++++++++++++++++++++++-----
 7 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.1.4
