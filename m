From: plaes@plaes.org (Priit Laes)
Date: Sun, 26 Mar 2017 20:20:21 +0300
Subject: [PATCH v2 6/6] clk: sunxi-ng: Display index when clock registration
 fails
In-Reply-To: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
Message-ID: <c2b949f92eff7ae8836af36d56a633e501e35caa.1490545262.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock index to clock registration failure message.

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
git-series 0.9.1
