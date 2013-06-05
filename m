From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  5 Jun 2013 16:54:42 -0700
Subject: [PATCHv3 0/3] 64bit friendly generic sched_clock
Message-ID: <1370476485-468-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok here's the second take at 64 bit support in generic sched_clock.
This assumes that the previous three patches in the v2 of this 
series have been applied.

I've also noticed that we probably need to update the mult/shift
calculation similar to how clocksources are done. Should we
just copy/paste the maxsec calculation code here or do something
else?

Stephen Boyd (3):
  sched_clock: Add support for >32 bit sched_clock
  ARM: arch_timer: Move to generic sched_clock framework
  arm64: Move to generic sched_clock infrastructure

 arch/arm/kernel/arch_timer.c | 14 ++------------
 arch/arm64/Kconfig           |  1 +
 arch/arm64/kernel/time.c     | 11 ++---------
 include/linux/sched_clock.h  |  3 +--
 kernel/time/sched_clock.c    | 46 ++++++++++++++++++++++++++------------------
 5 files changed, 33 insertions(+), 42 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
