From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:30 -0700
Subject: [PATCH v4 17/17] sched_clock: Deprecate setup_sched_clock()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-18-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Users of the generic sched_clock framework should use
sched_clock_register() instead of setup_sched_clock(). Mark the
function as deprecated.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/sched_clock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index cddf0c2..d3da3e2 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -14,7 +14,8 @@ extern void sched_clock_postinit(void);
 static inline void sched_clock_postinit(void) { }
 #endif
 
-extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
+/* Use sched_clock_register() instead */
+extern void __deprecated setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
 extern void sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
