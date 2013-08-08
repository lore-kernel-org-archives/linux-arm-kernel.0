From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu,  8 Aug 2013 10:01:26 +0530
Subject: [PATCH 1/1] clk: prima2: Fix incorrect placement of __initdata
Message-ID: <1375936286-32075-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/clk-prima2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-prima2.c b/drivers/clk/clk-prima2.c
index 643ca65..5ab95f1 100644
--- a/drivers/clk/clk-prima2.c
+++ b/drivers/clk/clk-prima2.c
@@ -1034,7 +1034,7 @@ enum prima2_clk_index {
 	usb0,  usb1,  maxclk,
 };
 
-static __initdata struct clk_hw* prima2_clk_hw_array[maxclk] = {
+static struct clk_hw *prima2_clk_hw_array[maxclk] __initdata = {
 	NULL, /* dummy */
 	NULL,
 	&clk_pll1.hw,
-- 
1.7.9.5
