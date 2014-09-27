From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 27 Sep 2014 11:11:58 +0530
Subject: [PATCH 2/3] clk: samsung: remove unnecessary CONFIG_OF from clk.c
In-Reply-To: <1411796519-19417-1-git-send-email-pankaj.dubey@samsung.com>
References: <1411796519-19417-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1411796519-19417-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/samsung/clk.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index deab84d..31bf391 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -281,7 +281,6 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
  * obtain the clock speed of all external fixed clock sources from device
  * tree and register it
  */
-#ifdef CONFIG_OF
 void __init samsung_clk_of_register_fixed_ext(struct samsung_clk_provider *ctx,
 			struct samsung_fixed_rate_clock *fixed_rate_clk,
 			unsigned int nr_fixed_rate_clk,
@@ -298,7 +297,6 @@ void __init samsung_clk_of_register_fixed_ext(struct samsung_clk_provider *ctx,
 	}
 	samsung_clk_register_fixed_rate(ctx, fixed_rate_clk, nr_fixed_rate_clk);
 }
-#endif
 
 /* utility function to get the rate of a specified clock */
 unsigned long _get_rate(const char *clk_name)
-- 
1.7.9.5
