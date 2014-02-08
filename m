From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  7 Feb 2014 22:02:09 -0800
Subject: [PATCH] ARM: smp_twd: Set the CLOCK_EVT_FEAT_PERCPU flag
Message-ID: <1391839329-30971-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The twd timers are per CPU devices. Set the corresponding flag to mark
them as such.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/kernel/smp_twd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 6591e26fc13f..85407473c97d 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -294,7 +294,7 @@ static void twd_timer_setup(void)
 
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-			CLOCK_EVT_FEAT_C3STOP;
+			CLOCK_EVT_FEAT_C3STOP | CLOCK_EVT_FEAT_PERCPU;
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
-- 
1.8.5.4
