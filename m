From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 26 Feb 2014 11:42:41 +0900
Subject: [PATCH] clk: samsung: fixed compiler warning [-Wpointer-to-int-cast]
Message-ID: <1393382561-5388-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiled using ARM64 cross compiler, gcc complains as

drivers/clk/samsung/clk.c:293:18:
warning: cast from pointer to integer of different size
[-Wpointer-to-int-cast]

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/samsung/clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 91bec3e..59142ba 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -278,7 +278,7 @@ void __init samsung_clk_of_register_fixed_ext(
 	for_each_matching_node_and_match(np, clk_matches, &match) {
 		if (of_property_read_u32(np, "clock-frequency", &freq))
 			continue;
-		fixed_rate_clk[(u32)match->data].fixed_rate = freq;
+		fixed_rate_clk[(unsigned long)match->data].fixed_rate = freq;
 	}
 	samsung_clk_register_fixed_rate(fixed_rate_clk, nr_fixed_rate_clk);
 }
-- 
1.7.9.5
