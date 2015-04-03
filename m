From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 18:13:34 +0100
Subject: [PATCH 14/14] clk: s2mps11: use clkdev_create()
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Message-ID: <E1Ye59y-0001Bq-DQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clkdev_create() is a shorter way to write clkdev_alloc() followed by
clkdev_add().  Use this instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/clk/clk-s2mps11.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index bfa1e64e267d..9b13a303d3f8 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -242,14 +242,12 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 			goto err_reg;
 		}
 
-		s2mps11_clk->lookup = clkdev_alloc(s2mps11_clk->clk,
+		s2mps11_clk->lookup = clkdev_create(s2mps11_clk->clk,
 					s2mps11_name(s2mps11_clk), NULL);
 		if (!s2mps11_clk->lookup) {
 			ret = -ENOMEM;
 			goto err_lup;
 		}
-
-		clkdev_add(s2mps11_clk->lookup);
 	}
 
 	for (i = 0; i < S2MPS11_CLKS_NUM; i++) {
-- 
1.8.3.1
