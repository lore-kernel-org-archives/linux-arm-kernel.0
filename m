From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Oct 2013 18:30:37 +0200
Subject: [PATCH 3/8] clk: max77686: Refactor successful exit of probe function
In-Reply-To: <1382027442-1992-1-git-send-email-t.figa@samsung.com>
References: <1382027442-1992-1-git-send-email-t.figa@samsung.com>
Message-ID: <1382027442-1992-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function can simply return 0, without jumping to a separate label,
which does exactly the same. This patch does not introduce any
functional change, just a clean-up.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/clk-max77686.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index e40ecdb..5d78460 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -178,7 +178,7 @@ static int max77686_clk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, max77686_clks);
 
-	goto out;
+	return 0;
 
 err_clk_pmic:
 	clkdev_drop(max77686_clks[MAX77686_CLK_CP]->lookup);
@@ -187,7 +187,6 @@ err_clk_cp:
 	clkdev_drop(max77686_clks[MAX77686_CLK_AP]->lookup);
 	kfree(max77686_clks[MAX77686_CLK_AP]->hw.clk);
 err_clk_ap:
-out:
 	return ret;
 }
 
-- 
1.8.3.2
