From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Sat, 21 Dec 2013 15:45:27 +0530
Subject: [PATCH 1/1] clk: si570: Remove redundant of_match_ptr helper
Message-ID: <1387620927-3315-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'clk_si570_of_match' is always compiled in. Hence the
helper macro is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/clk-si570.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index 5d0ac9f8e1ee..4bbbe32585ec 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -517,7 +517,7 @@ MODULE_DEVICE_TABLE(of, clk_si570_of_match);
 static struct i2c_driver si570_driver = {
 	.driver = {
 		.name = "si570",
-		.of_match_table = of_match_ptr(clk_si570_of_match),
+		.of_match_table = clk_si570_of_match,
 	},
 	.probe		= si570_probe,
 	.remove		= si570_remove,
-- 
1.7.9.5
