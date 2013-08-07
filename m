From: voice.shen@atmel.com (Bo Shen)
Date: Wed,  7 Aug 2013 15:47:40 +0800
Subject: [RFC PATCH] clock: correct the comparison parameter of MHz
Message-ID: <1375861660-32525-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

correct the comparison parameter of MHz from 4,000,000 to 1,000,000

Signed-off-by: Bo Shen <voice.shen@atmel.com>

---
 kernel/time/sched_clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index a326f27..62885f7 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -128,7 +128,7 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 	clocks_calc_mult_shift(&cd.mult, &cd.shift, rate, NSEC_PER_SEC, 0);
 
 	r = rate;
-	if (r >= 4000000) {
+	if (r >= 1000000) {
 		r /= 1000000;
 		r_unit = 'M';
 	} else if (r >= 1000) {
-- 
1.7.9.5
