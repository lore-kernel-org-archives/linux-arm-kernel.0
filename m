From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu,  1 Sep 2016 18:51:48 +0800
Subject: [PATCH] clk: sunxi-ng: mark ccu_nk_find_best() static
Message-ID: <1472727108-18388-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 1 warning when building kernel with W=1:
drivers/clk/sunxi-ng/ccu_nk.c:17:6: warning: no previous prototype for 'ccu_nk_find_best' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
So this patch marks it 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/clk/sunxi-ng/ccu_nk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index 4470ffc..2adb62e 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -14,7 +14,7 @@
 #include "ccu_gate.h"
 #include "ccu_nk.h"
 
-void ccu_nk_find_best(unsigned long parent, unsigned long rate,
+static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
 		      unsigned int max_n, unsigned int max_k,
 		      unsigned int *n, unsigned int *k)
 {
-- 
2.7.4
