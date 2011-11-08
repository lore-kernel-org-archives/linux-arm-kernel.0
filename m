From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  8 Nov 2011 10:34:03 -0800
Subject: [PATCH 1/8] msm: timer: Tighten #ifdef for local timer support
In-Reply-To: <1320777250-23263-1-git-send-email-sboyd@codeaurora.org>
References: <1320777250-23263-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1320777250-23263-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is more correct to only define the local timer support code
when CONFIG_LOCAL_TIMERS=y.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/timer.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index afeeca5..1cab559 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -279,7 +279,7 @@ static void __init msm_timer_init(void)
 	}
 }
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_LOCAL_TIMERS
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	static bool local_timer_inited;
@@ -321,8 +321,7 @@ void local_timer_stop(struct clock_event_device *evt)
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	disable_percpu_irq(evt->irq);
 }
-
-#endif
+#endif /* CONFIG_LOCAL_TIMERS */
 
 struct sys_timer msm_timer = {
 	.init = msm_timer_init
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
