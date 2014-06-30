From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:12:16 +0300
Subject: [PATCH] mtd: s3c2410: Move to clk_prepare_enable/clk_disable_unprepare
Message-ID: <1404155536-3032-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_prepare_enable/clk_disable_unprepare to make the driver
work properly with common clock framework.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/mtd/nand/s3c2410.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 79acbb8..6b97bf1 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -208,10 +208,10 @@ static void s3c2410_nand_clk_set_state(struct s3c2410_nand_info *info,
 
 	if (info->clk_state == CLOCK_ENABLE) {
 		if (new_state != CLOCK_ENABLE)
-			clk_disable(info->clk);
+			clk_disable_unprepare(info->clk);
 	} else {
 		if (new_state == CLOCK_ENABLE)
-			clk_enable(info->clk);
+			clk_prepare_enable(info->clk);
 	}
 
 	info->clk_state = new_state;
-- 
2.0.0
