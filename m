From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 15 Jan 2013 16:48:14 +0000
Subject: [RFC PATCH 0/4] b.L: Memory barriers and miscellaneous tidyups
Message-ID: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After much head-scratching and discussion, I have concluded that we
need comprehensive memory barriers in order to ensure that the
low-level synchronisation code executes robustly on all platforms.

DSBs are excessive on most situations though, so many DSBs can be
replces with DMBs.

As was observed in review, providing a C interface to the vlocks
makes little sense, so this series gets rid of it.

Dave Martin (4):
  ARM: b.L: Remove C declarations for vlocks
  ARM: b.L: vlocks: Add architecturally required memory barriers
  ARM: bL_entry: Match memory barriers to architectural requirements
  ARM: vexpress/dcscb: power_up_setup memory barrier cleanup

 arch/arm/common/bL_head.S            |   40 ++++++++-----------------------
 arch/arm/common/vlock.S              |    7 ++++-
 arch/arm/common/vlock.h              |   43 ----------------------------------
 arch/arm/mach-vexpress/dcscb_setup.S |    5 +--
 4 files changed, 18 insertions(+), 77 deletions(-)
 delete mode 100644 arch/arm/common/vlock.h

-- 
1.7.4.1
