From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Jul 2013 19:39:18 -0700
Subject: [PATCH 0/3] Cleanup sched_clock.h users
Message-ID: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset cleans up the last few stragglers using the sched_clock.h
header file in asm and removes the asm header.

A new one appeared in drivers/clocksource so I'm not sure who
wants to take that one.

Stephen Boyd (3):
  clocksource: orion: Use linux/sched_clock.h
  ARM: clps711x: Use linux/sched_clock.h
  ARM: Remove temporary sched_clock.h header

 arch/arm/include/asm/sched_clock.h | 4 ----
 arch/arm/mach-clps711x/common.c    | 2 +-
 drivers/clocksource/time-orion.c   | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)
 delete mode 100644 arch/arm/include/asm/sched_clock.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
