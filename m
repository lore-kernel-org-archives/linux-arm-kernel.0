From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 24 Nov 2017 12:25:30 +0530
Subject: [PATCH 3/6] clk: SPEAr: pr_err() strings should end with newlines
In-Reply-To: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <03a5ce213323863375e1fb3f85c0c3cc8c921a41.1511505932.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/spear/clk-frac-synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index 58d678b..cbdf43a 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -131,7 +131,7 @@ struct clk *clk_register_frac(const char *name, const char *parent_name,
 	struct clk *clk;
 
 	if (!name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
-		pr_err("Invalid arguments passed");
+		pr_err("Invalid arguments passed\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
1.9.1
