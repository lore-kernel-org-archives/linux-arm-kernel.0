From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 24 Nov 2017 12:25:28 +0530
Subject: [PATCH 1/6] clk: stm32f4: pr_err() strings should end with newlines
In-Reply-To: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <d5b9943c076a8ad168d9b0b3ba3aec7c9b8d7d06.1511505932.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/clk-stm32f4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 96c6b6b..da44f8d 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -1424,7 +1424,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 
 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_err("%s: unable to map resource", np->name);
+		pr_err("%s: unable to map resource\n", np->name);
 		return;
 	}
 
-- 
1.9.1
