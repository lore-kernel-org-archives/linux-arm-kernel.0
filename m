From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 21 Sep 2012 14:23:13 +0800
Subject: [PATCH] msm: clock: fix return value check in msm_clock_init()
Message-ID: <CAPgLHd9Fx-y8oqy0Ux85AUA9fbYvJYjS=FLs7z+ivdqOVtLqhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_get() returns ERR_PTR() not
NULL pointer. The NULL test in return value check should be
replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-msm/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index d9145df..fd52891 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -148,7 +148,7 @@ void __init msm_clock_init(struct clk_lookup *clock_tbl, unsigned num_clocks)
 	mutex_unlock(&clocks_mutex);
 
 	ebi1_clk = clk_get(NULL, "ebi1_clk");
-	BUG_ON(ebi1_clk == NULL);
+	BUG_ON(IS_ERR(ebi1_clk));
 
 }
 
