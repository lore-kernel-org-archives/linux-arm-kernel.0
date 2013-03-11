From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 00:44:00 +0100
Subject: [PATCH 2/4] clk: samsung: remove np check in clock init
In-Reply-To: <201303120042.09633.heiko@sntech.de>
References: <201303120042.09633.heiko@sntech.de>
Message-ID: <201303120044.00803.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This let to the suspend init never being reached on non-DT platforms.

Signed-off-by: Heiko Stueber <heiko@sntech.de>
---
 drivers/clk/samsung/clk.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index d36cdd5..1a5de69 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -57,8 +57,6 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 		unsigned long nr_rdump)
 {
 	reg_base = base;
-	if (!np)
-		return;
 
 #ifdef CONFIG_OF
 	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
-- 
1.7.2.3
