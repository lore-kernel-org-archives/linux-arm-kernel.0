From: davidb@codeaurora.org (David Brown)
Date: Thu, 13 Sep 2012 11:59:15 -0700
Subject: [GIT PULL 1/5] msm cleanups (resend)
In-Reply-To: <20120913185342.GA29823@codeaurora.org>
References: <20120913185342.GA29823@codeaurora.org>
Message-ID: <20120913185915.GF30032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resending to proper In-Reply-To]

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-cleanup-for-3.7

for you to fetch changes up to e63770acb3c1e7334885ed4673aed1375f93484a:

  ARM: msm: Remove uncompiled board-msm7x27 (2012-09-13 11:13:08 -0700)

----------------------------------------------------------------
Various cleanups for the msm targets.  Most of this is removing dead
code, along with a fix of a sparse warning, a list fix from a semantic
patch, and marking some functions as static.

----------------------------------------------------------------
Stephen Boyd (6):
      ARM: msm: Remove msm_hw_reset_hook
      ARM: msm: clock-pcom: Mark functions static
      ARM: msm: Remove unused idle.c
      ARM: msm: Fix sparse warnings due to incorrect type
      ARM: msm: Remove unused acpuclock-arm11
      ARM: msm: Remove uncompiled board-msm7x27

Wei Yongjun (1):
      ARM: msm: dma: use list_move_tail instead of list_del/list_add_tail

 arch/arm/mach-msm/Makefile              |   4 +-
 arch/arm/mach-msm/acpuclock-arm11.c     | 525 --------------------------------
 arch/arm/mach-msm/acpuclock.h           |  32 --
 arch/arm/mach-msm/board-mahimahi.c      |   1 -
 arch/arm/mach-msm/board-msm7x27.c       | 170 -----------
 arch/arm/mach-msm/board-sapphire.c      |   1 -
 arch/arm/mach-msm/clock-pcom.c          |  18 +-
 arch/arm/mach-msm/dma.c                 |   3 +-
 arch/arm/mach-msm/idle.c                |  49 ---
 arch/arm/mach-msm/include/mach/board.h  |  10 -
 arch/arm/mach-msm/include/mach/system.h |  19 --
 arch/arm/mach-msm/io.c                  |   3 +-
 arch/arm/mach-msm/proc_comm.c           |   1 -
 arch/arm/mach-msm/smd.c                 |   7 -
 arch/arm/mach-msm/timer.c               |   2 +-
 15 files changed, 14 insertions(+), 831 deletions(-)
 delete mode 100644 arch/arm/mach-msm/acpuclock-arm11.c
 delete mode 100644 arch/arm/mach-msm/acpuclock.h
 delete mode 100644 arch/arm/mach-msm/board-msm7x27.c
 delete mode 100644 arch/arm/mach-msm/idle.c
 delete mode 100644 arch/arm/mach-msm/include/mach/system.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
