From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sat,  1 Jun 2013 23:39:38 -0700
Subject: [PATCHv2 1/6] ARM: sched_clock: Remove unused needs_suspend member
In-Reply-To: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1370155183-31421-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The needs_suspend member is unused now that we always do the
suspend/resume handling (see 6a4dae5 (ARM: 7565/1: sched: stop
sched_clock() during suspend, 2012-10-23)).

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/sched_clock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index e8edcaa..45efe86 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -24,7 +24,6 @@ struct clock_data {
 	u32 mult;
 	u32 shift;
 	bool suspended;
-	bool needs_suspend;
 };
 
 static void sched_clock_poll(unsigned long wrap_ticks);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
