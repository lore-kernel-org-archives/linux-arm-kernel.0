From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Apr 2013 17:29:02 -0700
Subject: [PATCH 0/4] ARM 64 bit sched_clock take #2
In-Reply-To: <51709FD7.8050408@gmail.com>
References: <51709FD7.8050408@gmail.com>
Message-ID: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is what I was thinking. I don't see why we can't move this to generic code and have arm64 use it too. Those patches will follow once I find an arm64
compiler.

First two patches should probably go in even if the 64 bit stuff doesn't go in
at the same time.

Stephen Boyd (4):
  ARM: sched_clock: Remove unused needs_suspend member
  ARM: sched_clock: Return suspended count earlier
  ARM: sched_clock: Add support for >32 bit sched_clock
  ARM: arch_timer: Move to setup_sched_clock_64()

 arch/arm/include/asm/sched_clock.h |   5 +-
 arch/arm/kernel/arch_timer.c       |  14 +----
 arch/arm/kernel/sched_clock.c      | 111 ++++++++++++++++++++++++++-----------
 3 files changed, 84 insertions(+), 46 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
