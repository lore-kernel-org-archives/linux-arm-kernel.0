From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2011 16:03:57 -0700
Subject: [PATCH] ARM: Mark broadcast_timer_setup() __cpuinit
Message-ID: <1303427037-12413-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is only called by percpu_timer_setup() which is
also __cpuinit marked. Thus it's safe to mark this function as
__cpuinit too.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8fe05ad..f29b8a2 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -479,7 +479,7 @@ static void broadcast_timer_set_mode(enum clock_event_mode mode,
 {
 }
 
-static void broadcast_timer_setup(struct clock_event_device *evt)
+static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
 {
 	evt->name	= "dummy_timer";
 	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
