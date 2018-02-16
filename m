From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 16 Feb 2018 17:47:07 +0100
Subject: [PATCH 1/6] nand: davinci: rename the platform driver
In-Reply-To: <20180216164712.25898-1-brgl@bgdev.pl>
References: <20180216164712.25898-1-brgl@bgdev.pl>
Message-ID: <20180216164712.25898-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock
lookup table") broke the nand support in board file mode for
da850-based boards. Instead of reverting it and breaking the DT users
in the process (due to clock lookup), rename the driver to match the
clock table before renaming the users.

Fixes: d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock lookup table")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mtd/nand/davinci_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index ccc8c43abcff..4fb143bf1872 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -865,7 +865,7 @@ static struct platform_driver nand_davinci_driver = {
 	.probe		= nand_davinci_probe,
 	.remove		= nand_davinci_remove,
 	.driver		= {
-		.name	= "davinci_nand",
+		.name	= "davinci-nand",
 		.of_match_table = of_match_ptr(davinci_nand_of_match),
 	},
 };
-- 
2.16.1
