From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Jul 2016 15:04:24 +0800
Subject: [PATCH 2/9] clk: sunxi-ng: nk: Make ccu_nk_find_best static
In-Reply-To: <1469516671-19377-1-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
Message-ID: <1469516671-19377-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

make C=2 reports:

  CHECK   drivers/clk/sunxi-ng/ccu_nk.c
drivers/clk/sunxi-ng/ccu_nk.c:17:6: warning: symbol 'ccu_nk_find_best' was
not declared. Should it be static?

ccu_nk_find_best is only used within ccu_nk.c. So make it static to get
rid of this warning.

Fixes: adbfb0056e03 ("clk: sunxi-ng: Add N-K-factor clock support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_nk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index 4470ffc8cf0d..d6fafb397489 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -14,9 +14,9 @@
 #include "ccu_gate.h"
 #include "ccu_nk.h"
 
-void ccu_nk_find_best(unsigned long parent, unsigned long rate,
-		      unsigned int max_n, unsigned int max_k,
-		      unsigned int *n, unsigned int *k)
+static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
+			     unsigned int max_n, unsigned int max_k,
+			     unsigned int *n, unsigned int *k)
 {
 	unsigned long best_rate = 0;
 	unsigned int best_k = 0, best_n = 0;
-- 
2.8.1
