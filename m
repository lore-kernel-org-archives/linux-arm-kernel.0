From: plaes@plaes.org (Priit Laes)
Date: Wed,  5 Apr 2017 19:52:27 +0300
Subject: [PATCH] clk: sunxi-ng: Display index when clock registration fails
Message-ID: <20170405165227.6985-1-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock index to clock registration failure message. Clock name
is sometimes not available, when things go really wrong.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 8a47baf..188fa50 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -63,8 +63,8 @@ int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 
 		ret = clk_hw_register(NULL, hw);
 		if (ret) {
-			pr_err("Couldn't register clock %s\n",
-			       clk_hw_get_name(hw));
+			pr_err("Couldn't register clock %d - %s\n",
+			       i, clk_hw_get_name(hw));
 			goto err_clk_unreg;
 		}
 	}
-- 
2.9.3
