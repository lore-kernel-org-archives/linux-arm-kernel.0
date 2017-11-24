From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 24 Nov 2017 12:25:31 +0530
Subject: [PATCH 4/6] SPEAr: clk: pr_err() strings should end with newlines
In-Reply-To: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <35a712ed8ee10491c0a605d0cc825250286370a4.1511505932.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/spear/clk-gpt-synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
index 1a722e9..1cf219a6 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -120,7 +120,7 @@ struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
 	struct clk *clk;
 
 	if (!name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
-		pr_err("Invalid arguments passed");
+		pr_err("Invalid arguments passed\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
1.9.1
