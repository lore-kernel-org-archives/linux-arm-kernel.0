From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 00:44:29 +0100
Subject: [PATCH 3/4] clk: samsung: always allocate the clk_table
In-Reply-To: <201303120042.09633.heiko@sntech.de>
References: <201303120042.09633.heiko@sntech.de>
Message-ID: <201303120044.29499.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to allow looking up previous created clocks when
adding separate aliases to them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 1a5de69..7c943f8 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -58,11 +58,11 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 {
 	reg_base = base;
 
-#ifdef CONFIG_OF
 	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
 	if (!clk_table)
 		panic("could not allocate clock lookup table\n");
 
+#ifdef CONFIG_OF
 	clk_data.clks = clk_table;
 	clk_data.clk_num = nr_clks;
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-- 
1.7.2.3
