From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 23 May 2018 18:46:54 +0100
Subject: [PATCH v4 0/2] arm64: signal: Report signal frame size to userspace
 via auxv
Message-ID: <1527097616-25214-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for telling userspace the size of the signal
frame via a new AT_MINSIGSTKSZ entry in the aux vector.

This is an update to a previous v3 standalone patch [1], which is
presented here as patch 2 with some updates in response to review.
See the changelog in the patch for details.

Patch 1 is new, and thins out some WARN_ON() checks for timely
initialisation of sve_max_vl that now look excessive, to strengthen
the case for not adding more such checks in patch 2.

[1] [PATCH v3] arm64: signal: Report signal frame size to userspace via auxv
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/578585.html


Dave Martin (2):
  arm64/sve: Thin out initialisation sanity-checks for sve_max_vl
  arm64: signal: Report signal frame size to userspace via auxv

 arch/arm64/include/asm/elf.h         | 11 ++++++++
 arch/arm64/include/asm/processor.h   |  5 ++++
 arch/arm64/include/uapi/asm/auxvec.h |  3 ++-
 arch/arm64/kernel/cpufeature.c       |  1 +
 arch/arm64/kernel/fpsimd.c           | 17 +++---------
 arch/arm64/kernel/ptrace.c           |  3 ---
 arch/arm64/kernel/signal.c           | 52 +++++++++++++++++++++++++++++++-----
 7 files changed, 68 insertions(+), 24 deletions(-)

-- 
2.1.4
