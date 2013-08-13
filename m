From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 13 Aug 2013 18:29:43 +0100
Subject: [PATCH v3 5/6] drivers: clocksource: enable hwcaps for event stream
 on ARM arch timer
In-Reply-To: <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376414984-14182-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch enables hwcap definition to the users for event stream
feature on ARM architected timers.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6301ee5..05d1e13 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -162,6 +162,9 @@ static int arch_timer_setup(struct clock_event_device *clk)
 		pos--;
 	arch_counter_set_user_access(min(pos, 15));
 
+	/* enable hwcap definition to the users for event stream feature */
+	arch_timer_set_hwcap_evtstrm();
+
 	return 0;
 }
 
-- 
1.8.1.2
