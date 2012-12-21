From: torbenh@linutronix.de (Torben Hohn)
Date: Fri, 21 Dec 2012 15:06:16 +0100
Subject: [PATCH 2/2] mxs timer: decrease mxs_clockevent_device.min_delta_ns to
 2 clock cycles
In-Reply-To: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
References: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
Message-ID: <1356098776-10498-3-git-send-email-torbenh@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Torben Hohn <torbenh@linutronix.de>
---
 arch/arm/mach-mxs/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index 689a2b5..cf45e0a 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -219,7 +219,7 @@ static int __init mxs_clockevent_init(struct clk *timer_clk)
 		mxs_clockevent_device.max_delta_ns =
 			clockevent_delta2ns(0xfffffffe, &mxs_clockevent_device);
 		mxs_clockevent_device.min_delta_ns =
-			clockevent_delta2ns(0xf, &mxs_clockevent_device);
+			clockevent_delta2ns(0x2, &mxs_clockevent_device);
 	}
 
 	clockevents_register_device(&mxs_clockevent_device);
-- 
1.7.10.4
