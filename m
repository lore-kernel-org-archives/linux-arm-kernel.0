From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 7 Aug 2015 21:03:21 -0500
Subject: [PATCH 0/2] fix vdso coarse clock monotonicity regressions
Message-ID: <1438999403-5770-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 906c55579a63 ("timekeeping: Copy the shadow-timekeeper over the
real timekeeper last") made it so the user can observe the coarse
clocks going backwards on arm and arm64, if they're really looking for
it.

Technically these are fixing regressions versus 4.1, but I won't be
bothered if they don't make 4.2 final at this late stage, since only
the (seldom-used?) coarse clocks are affected.

I'd like to collect review/acks for these now and make sure they at
least make it into 4.3-rc1 (and -stable after that).


Nathan Lynch (2):
  ARM: VDSO: fix coarse clock monotonicity regression
  arm64: VDSO: fix coarse clock monotonicity regression

 arch/arm/kernel/vdso.c   | 7 +++----
 arch/arm64/kernel/vdso.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.1.0
