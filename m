From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  7 Sep 2011 16:59:15 +0100
Subject: [RFC PATCH 0/3] ARM: iwmmxt/pj4 fixes for v7/Thumb-2
Message-ID: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iwmmxt and pj4 support code contains some code which isn't
compatible with Thumb-2 and looks possibly inappropriate for v7.

There is also an issue with Makefile rules causing iwmmxt.S to be
built for the wrong architecture.

This series attempts to fix those issues.  However, I'm not totally
happy with it -- if someone with relevant boards and/or experience
can test or comment, that would be appreciated.

In particular, the current makefile rules are still not really
right.  To avoid excessive pain and disruption, simpler but
somewhat incorrect changes are made in the Makefile, and iwmmxt.S
is changed for Thumb-2 kernels only.  This may be adequete, but I
don't kave the required knowledge to be sure.

If someone with some platform knowledge can comment on whether it
appears valid to replace the old instruction sequences with ISBs,
that would be appreciated too.  In this series I'm currently making
assumptions based on the core architecture.

Dave Martin (3):
  ARM: iwmmxt: Fix Makefile rules for building iwmmxt for Thumb-2
  ARM: iwmmxt: Port problematic iwmmxt support code to v7/Thumb-2
  ARM: pxa/pj4: Port problematic pj4 support code to v7/Thumb-2

 arch/arm/kernel/Makefile  |    7 +++++++
 arch/arm/kernel/iwmmxt.S  |    9 +++++++++
 arch/arm/kernel/pj4-cp0.c |    4 ++++
 3 files changed, 20 insertions(+), 0 deletions(-)

-- 1.7.4.1
