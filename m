From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 31 Oct 2013 12:55:48 +0100
Subject: [PATCH] ARM: imx6q: add missing sentinel to divider table
Message-ID: <1383220548-8622-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_enet_ref_table[] is missing a final empty entry as end of list
marker. Also make the existing markers more obvious.
Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-imx/clk-imx6q.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index d756d91..8979470 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -122,13 +122,14 @@ static struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 1, .div = 10, },
 	{ .val = 2, .div = 5, },
 	{ .val = 3, .div = 4, },
+	{ /* sentinel */ }
 };
 
 static struct clk_div_table post_div_table[] = {
 	{ .val = 2, .div = 1, },
 	{ .val = 1, .div = 2, },
 	{ .val = 0, .div = 4, },
-	{ }
+	{ /* sentinel */ }
 };
 
 static struct clk_div_table video_div_table[] = {
@@ -136,7 +137,7 @@ static struct clk_div_table video_div_table[] = {
 	{ .val = 1, .div = 2, },
 	{ .val = 2, .div = 1, },
 	{ .val = 3, .div = 4, },
-	{ }
+	{ /* sentinel */ }
 };
 
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
-- 
1.7.2.5
