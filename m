From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:22:52 -0500
Subject: [PATCH 223/493] clk: remove use of __devinit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-223-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Mike Turquette <mturquette@ti.com> 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: patches at opensource.wolfsonmicro.com 
---
 drivers/clk/clk-max77686.c | 2 +-
 drivers/clk/clk-twl6040.c  | 2 +-
 drivers/clk/clk-wm831x.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index fff7e6f..fe449c2 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -143,7 +143,7 @@ static int max77686_clk_register(struct device *dev,
 	return 0;
 }
 
-static __devinit int max77686_clk_probe(struct platform_device *pdev)
+static int max77686_clk_probe(struct platform_device *pdev)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct max77686_clk **max77686_clks;
diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 5f2eb1f..93dd975 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -78,7 +78,7 @@ static struct clk_init_data wm831x_clkout_init = {
 	.flags = CLK_IS_ROOT,
 };
 
-static int __devinit twl6040_clk_probe(struct platform_device *pdev)
+static int twl6040_clk_probe(struct platform_device *pdev)
 {
 	struct twl6040 *twl6040 = dev_get_drvdata(pdev->dev.parent);
 	struct twl6040_clk *clkdata;
diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index 6374dc4..f31a642 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -350,7 +350,7 @@ static struct clk_init_data wm831x_clkout_init = {
 	.flags = CLK_SET_RATE_PARENT,
 };
 
-static __devinit int wm831x_clk_probe(struct platform_device *pdev)
+static int wm831x_clk_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_clk *clkdata;
-- 
1.8.0
