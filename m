From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Feb 2013 23:27:12 -0800
Subject: [PATCH 1/8] ARM: smp: Lower rating of dummy broadcast device
In-Reply-To: <1361518039-16663-1-git-send-email-sboyd@codeaurora.org>
References: <1361518039-16663-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1361518039-16663-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the near future the dummy broadcast device will always be
registered with the clockevent core. If the rating of the dummy
is higher than the rating of the real clockevent the clockevents
core will try to replace the real clockevent with the dummy
broadcast. We don't want this to happen, so lower the rating to
something no good clockevent should choose.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fa86d1c..2d5197d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -479,7 +479,7 @@ static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
 	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
 			  CLOCK_EVT_FEAT_PERIODIC |
 			  CLOCK_EVT_FEAT_DUMMY;
-	evt->rating	= 400;
+	evt->rating	= 100;
 	evt->mult	= 1;
 	evt->set_mode	= broadcast_timer_set_mode;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
