From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 May 2018 16:17:06 +0100
Subject: [PATCH v5 0/2] arm64: signal: Report signal frame size to userspace
 via auxv
Message-ID: <1527261428-6662-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for telling userspace the size of the signal
frame via a new AT_MINSIGSTKSZ entry in the aux vector.

This is an update to [1].  Changes are minor.  The main difference is
that no attempt is made to give userspace a sensible AT_MINSIGSTKSZ if
initialisation goes wrong, since this is indicative of a kernel bug
anyway.

See individual patches for the delta.

[1] [PATCH v4 0/2] arm64: signal: Report signal frame size to userspace via auxv
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580284.html


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
