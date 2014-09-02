From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  2 Sep 2014 16:02:07 -0700
Subject: [PATCH 1/3] clk: zynq: Remove unnecessary OOM message
In-Reply-To: <1409698929-30143-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409698929-30143-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1409698929-30143-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As checkpatch suggests:
  WARNING: Possible unnecessary 'out of memory' message,
remove an error message after failing kmalloc() from the PLL driver.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/zynq/pll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
index cec97596fe65..00d72fb5c036 100644
--- a/drivers/clk/zynq/pll.c
+++ b/drivers/clk/zynq/pll.c
@@ -211,10 +211,8 @@ struct clk *clk_register_zynq_pll(const char *name, const char *parent,
 	};
 
 	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
-	if (!pll) {
-		pr_err("%s: Could not allocate Zynq PLL clk.\n", __func__);
+	if (!pll)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	/* Populate the struct */
 	pll->hw.init = &initd;
-- 
2.1.0.1.g27b9230
