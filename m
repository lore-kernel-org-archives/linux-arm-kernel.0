From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 12 Feb 2017 00:50:18 +0530
Subject: [PATCH] clocksource: add __ro_after_init to cyclecounter
Message-ID: <1486840818-22214-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The object cyclecounter of type cyclecounter is not getting modified
after getting initialized by arch_counter_register. Apart from
initialization in arch_counter_register it is also passed as an argument
to the function timecounter_init but this argument is of type const.
Therefore, add __ro_after_init to its declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4c8c3fb..a10506b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -580,7 +580,7 @@ static u64 arch_counter_read_cc(const struct cyclecounter *cc)
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static struct cyclecounter cyclecounter = {
+static struct cyclecounter cyclecounter __ro_after_init = {
 	.read	= arch_counter_read_cc,
 	.mask	= CLOCKSOURCE_MASK(56),
 };
-- 
1.9.1
