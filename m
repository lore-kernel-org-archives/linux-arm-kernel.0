From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:19:59 -0500
Subject: [PATCH 050/493] clk: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-50-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
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
index ac5f543..fff7e6f 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -223,7 +223,7 @@ static struct platform_driver max77686_clk_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = max77686_clk_probe,
-	.remove = __devexit_p(max77686_clk_remove),
+	.remove = max77686_clk_remove,
 	.id_table = max77686_clk_id,
 };
 
diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index f4a3389..5f2eb1f 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -115,7 +115,7 @@ static struct platform_driver twl6040_clk_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = twl6040_clk_probe,
-	.remove = __devexit_p(twl6040_clk_remove),
+	.remove = twl6040_clk_remove,
 };
 
 module_platform_driver(twl6040_clk_driver);
diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index db4fbf2..6374dc4 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -396,7 +396,7 @@ static int __devexit wm831x_clk_remove(struct platform_device *pdev)
 
 static struct platform_driver wm831x_clk_driver = {
 	.probe = wm831x_clk_probe,
-	.remove = __devexit_p(wm831x_clk_remove),
+	.remove = wm831x_clk_remove,
 	.driver		= {
 		.name	= "wm831x-clk",
 		.owner	= THIS_MODULE,
-- 
1.8.0
