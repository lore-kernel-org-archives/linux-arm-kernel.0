From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 19 Aug 2011 16:56:55 +0530
Subject: [PATCH] ARM: S5P: fix bug in spdif_clk_get_rate
Message-ID: <1313753215-29173-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should be passing the parent clk object when
calling for parent rate.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/plat-s5p/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index 02af235..5f84a3f 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -192,7 +192,7 @@ unsigned long s5p_spdif_get_rate(struct clk *clk)
 	if (IS_ERR(pclk))
 		return -EINVAL;
 
-	rate = pclk->ops->get_rate(clk);
+	rate = pclk->ops->get_rate(pclk);
 	clk_put(pclk);
 
 	return rate;
-- 
1.7.2.3
